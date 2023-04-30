/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package com.mycompany.guiproyecto;

import java.awt.Color;
import java.sql.Connection;

/**
 *
 * @author juanp
 */
public class StartFrame extends javax.swing.JFrame {

    /**
     * Creates new form StartFrame
     */
    
    Connection connection;
    public StartFrame(Connection myConnection) {
        this.connection = myConnection;
        initComponents();
        
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        cImpButton = new javax.swing.JButton();
        busqText = new javax.swing.JTextField();
        busqButton = new javax.swing.JButton();
        jLabel2 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jLabel1.setText("Sistema de calculo de impuestos de renta");

        cImpButton.setText("Calcular impuestos mensuales");
        cImpButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cImpButtonActionPerformed(evt);
            }
        });

        busqText.setForeground(new java.awt.Color(153, 153, 153));
        busqText.setText("Buscar por ID");
        busqText.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusGained(java.awt.event.FocusEvent evt) {
                busqTextFocusGained(evt);
            }
            public void focusLost(java.awt.event.FocusEvent evt) {
                busqTextFocusLost(evt);
            }
        });
        busqText.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                busqTextActionPerformed(evt);
            }
        });

        busqButton.setText("Buscar");
        busqButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                busqButtonActionPerformed(evt);
            }
        });

        jLabel2.setText("Consulta de Datos");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(96, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(cImpButton)
                    .addComponent(jLabel1))
                .addGap(87, 87, 87))
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(busqText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(busqButton))
                    .addComponent(jLabel2))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1)
                .addGap(18, 18, 18)
                .addComponent(cImpButton)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 186, Short.MAX_VALUE)
                .addComponent(jLabel2)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(busqText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(busqButton))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void cImpButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cImpButtonActionPerformed
        // TODO add your handling code here:
        System.out.println("calling Calcular impuestos stored procedure");
        //CallableStatement calable = connection.prepareCall(callString);
        
    }//GEN-LAST:event_cImpButtonActionPerformed

    private void busqTextActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_busqTextActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_busqTextActionPerformed

    private void busqButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_busqButtonActionPerformed
        // TODO add your handling code here:
        
        System.out.println("calling Buscar Por ID stored procedure, with arg: " + busqText.getText());
    }//GEN-LAST:event_busqButtonActionPerformed

    private void busqTextFocusGained(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_busqTextFocusGained
        // TODO add your handling code here:
        busqText.setText("");
        busqText.setForeground(Color.BLACK);
    }//GEN-LAST:event_busqTextFocusGained

    private void busqTextFocusLost(java.awt.event.FocusEvent evt) {//GEN-FIRST:event_busqTextFocusLost
        if (busqText.getText().isEmpty()) {
            busqText.setForeground(Color.GRAY);
            busqText.setText("Buscar por ID");
        }
    }//GEN-LAST:event_busqTextFocusLost

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(StartFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(StartFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(StartFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(StartFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new StartFrame(NULL).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton busqButton;
    private javax.swing.JTextField busqText;
    private javax.swing.JButton cImpButton;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    // End of variables declaration//GEN-END:variables
}