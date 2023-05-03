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
    
    
    public static void main(String[] args) throws ClassNotFoundException {
        
        //Se debe modificar esto para el login correcto de la base de datos
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        String connectionUrl = "jdbc:sqlserver://ChesPavil;encrypt=false";
        String user = "datagrip";
        String pass = "1234";
//        String connectionUrl = "jdbc:sqlserver://localhost:1433;databaseName=taxesDB;encrypt=true;trustServerCertificate=true;user=Jenaro;password=Jema0529";
        Connection connection ;
        try {
            //se conecta a la BD
            connection = DriverManager.getConnection(connectionUrl, user, pass);
//            connection = DriverManager.getConnection(connectionUrl);
            System.out.println("Connection" + connection.isValid(10));
           
            
                //se ejecta el GUI
            StartFrame myFrame = new StartFrame(connection);
            myFrame.setVisible(true); 
        
        
        
        } catch (SQLException ex) {
            Logger.getLogger(GuiProyecto.class.getName()).log(Level.SEVERE, null, ex);
        }
        
   
    }
}
