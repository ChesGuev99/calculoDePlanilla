/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.guiproyecto;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author juanp
 */
public class GuiProyecto {
    
    public static void calcular_Deducciones(Connection connection) throws SQLException{
        PreparedStatement stmt;
        stmt = connection.prepareStatement("SELECT COUNT(*) FROM Employee");
        ResultSet rs = stmt.executeQuery();
        rs.next();
        int all_employees = rs.getInt(1);
        
        stmt = connection.prepareStatement("SELECT idn FROM Employee");
        rs = stmt.executeQuery();
        rs.next();
        CallableStatement proc = connection.prepareCall("{call start_payroll(?,?)}");
        LocalDate today = LocalDate.now();
        
        // Obtener el primer día del mes actual
        LocalDate firstDayOfMonth = today.withDayOfMonth(1);
        
        // Obtener el último día del mes actual
        LocalDate lastDayOfMonth = today.withDayOfMonth(today.lengthOfMonth());
        
        // Formatear las fechas en formato aaaa/mm/dd
        
        
        Date start = Date.valueOf(firstDayOfMonth);
        Date end = Date.valueOf(lastDayOfMonth);
        
        proc.setDate(1,start);
        proc.setDate(2,end);
        
        proc.execute();
        
        int batch_size = 1000;
        
        connection.setAutoCommit(false);
        
        proc = connection.prepareCall("{call calculate_deductions_by_employee(?)}");
        
        for (int i = 0;i < all_employees;i++){
            proc.setInt(1,rs.getInt(1));
            rs.next();
            
            proc.addBatch();
            
            if (i % batch_size == 0) {
                proc.executeBatch();
            }  
        }
        
        proc.executeBatch();
        connection.commit();
           
        
    }
    
    public static void main(String[] args) throws ClassNotFoundException {
        
        //Se debe modificar esto para el login correcto de la base de datos
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String connectionUrl = "jdbc:sqlserver://localhost:1433;databaseName=taxesDB;encrypt=true;trustServerCertificate=true;user=Jenaro;password=Jema0529";
        Connection connection ;
        try {
            //se conecta a la BD
            connection = DriverManager.getConnection(connectionUrl);
            System.out.println("Connection" + connection.isValid(10));
            
            calcular_Deducciones(connection);
            
                //se ejecta el GUI
            StartFrame myFrame = new StartFrame(connection);
            myFrame.setVisible(true); 
        
        
        
        } catch (SQLException ex) {
            Logger.getLogger(GuiProyecto.class.getName()).log(Level.SEVERE, null, ex);
        }
        
   
    }
}
