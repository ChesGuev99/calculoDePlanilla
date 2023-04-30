/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.guiproyecto;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author juanp
 */
public class GuiProyecto {
    public static void main(String[] args) {
        
        //Se debe modificar esto para el login correcto de la base de datos
        String connectionUrl ="jdbc:sqlserver://DESKTOP-E9H1059;user=admin;encrypt=false";
        Connection connection ;
        try {
            //se conecta a la BD
            connection = DriverManager.getConnection(connectionUrl);
            System.out.println("Connection" + connection.isValid(10));
        
                //se ejecta el GUI
            StartFrame myFrame = new StartFrame(connection);
            myFrame.setVisible(true); 
        
        
        
        } catch (SQLException ex) {
            Logger.getLogger(GuiProyecto.class.getName()).log(Level.SEVERE, null, ex);
        }
        
   
    }
}
