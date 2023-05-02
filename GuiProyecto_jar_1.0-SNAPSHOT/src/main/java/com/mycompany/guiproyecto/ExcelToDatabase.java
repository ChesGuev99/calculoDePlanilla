package com.mycompany.guiproyecto;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

// Class to read the excel file and insert the data into the database
public class ExcelToDatabase {
    String excelFilePath = "C:\\Users\\anagu\\OneDrive - Estudiantes ITCR\\SemestreI2023\\Aseguramiento\\calculoDePlanilla\\GuiProyecto_jar_1.0-SNAPSHOT\\src\\main\\java\\com\\mycompany\\guiproyecto\\data.csv";

    PreparedStatement statement;
    Connection connection;
    String sql = "insert into " +
            "dbo.Employee (idn, name, lastname1, lastname2, gross_salary, birthdate, " +
            "id_organization, id_department, kids_number, is_married, status) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    boolean connect() {
        String connectionUrl = "jdbc:sqlserver://ChesPavil;encrypt=false";
        String user = "datagrip";
        String pass = "1234";
        try {
            //se conecta a la BD
            connection = DriverManager.getConnection(connectionUrl, user, pass);
            System.out.println("Connection" + connection.isValid(10));

            statement = connection.prepareStatement(sql);

            return true;

        } catch (SQLException ex) {
            Logger.getLogger(GuiProyecto.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    void readExcel() throws SQLException {
        try {
            FileInputStream inputStream = new FileInputStream(new File(excelFilePath));
            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet firstSheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = firstSheet.iterator();

            while (rowIterator.hasNext()) {
                Row nextRow = rowIterator.next();
                Iterator<Cell> cellIterator = nextRow.cellIterator();

                while (cellIterator.hasNext()) {
                    Cell nextCell = cellIterator.next();
                    int columnIndex = nextCell.getColumnIndex();
                    setByPosition(columnIndex, nextCell.getStringCellValue());

                }
                randomData();
                System.out.println(statement+"\n");
                statement.executeUpdate();
            }
            workbook.close();
            connection.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    void readCSV() throws FileNotFoundException, SQLException, ParseException {
        Scanner sc = new Scanner(new File(excelFilePath));
        sc.nextLine();
        System.out.println("scanner created");
        sc.useDelimiter(";");   // sets the delimiter pattern
        int posicion = 0;
        while (sc.hasNext()) { // returns a boolean value
            String value = sc.next();
            setByPosition(posicion, value);
            posicion++;
            if (posicion == 9) {
                randomData();
                System.out.println(statement+"\n");
                statement.executeUpdate();
                posicion = 0;
            }
        }
        sc.close();  // closes the scanner
        System.out.println("scanner closed");
    }

    void setByPosition(int position, String value) throws SQLException, ParseException {
        switch (position) {
            case 0:
                int idn = Integer.parseInt(value);
                statement.setInt(1, idn);
                break;
            case 1:
            case 2:
            case 3:
                statement.setString(position+1, value);
                break;
            case 4:
                float grossSalary = Float.parseFloat(value);
                statement.setFloat(5, grossSalary);
                break;
            case 5:
                String birthdate = convertToSqlServerDateTime(value);
                statement.setString(6, birthdate);
                break;
            case 6:

            case 7:
                int newInt = Integer.parseInt(value.split("\\.")[0]);
                statement.setInt(position+1, newInt);
                break;
        }
        System.out.println("Data: " + position + " - " + value);
    }

    String convertToSqlServerDateTime(String inputDate) throws ParseException, ParseException {
        SimpleDateFormat inputFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");
        Date date = inputFormat.parse(inputDate);

        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String outputDate = outputFormat.format(date);

        return outputDate;
    }

    void randomData() throws SQLException {
        // kids number will be random
        int kidsNumber = ((int) (Math.random() * 10));
        statement.setInt(9, kidsNumber);
        System.out.println("Data: " + 9 + " - " + kidsNumber);
        // is married will be random
        int isMarried = ((int) (Math.random() * 2));
        statement.setInt(10, isMarried);
        System.out.println("Data: " + 10 + " - " + isMarried);
        // status will be active by default
        int status = 1;
        statement.setInt(11, status);
        System.out.println("Data: " + 11 + " - " + status);
        System.out.println("random data");
    }



    public static void main(String[] args) throws SQLException, FileNotFoundException, ParseException {
        ExcelToDatabase excelToDatabase = new ExcelToDatabase();
        if (excelToDatabase.connect()) {
            excelToDatabase.readCSV();
        }
    }
}
