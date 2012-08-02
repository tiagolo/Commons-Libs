package org.commonsLibs.java.report.servlet;
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.commonsLibs.java.report.dictionary.ReportDictionary;
import org.commonsLibs.java.report.service.ReportService;
import org.springframework.web.multipart.MultipartRequest;

/**
 *
 * @author Tiago Lopes
 */
public class UploadServlet extends HttpServlet {


    /**
     * 
     */
    private static final long serialVersionUID = 1722655159584954786L;

    
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet para Upload de arquivos";
    }
    
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	    	
    	request.setAttribute("msg","Não é possível acessar esta página");
    	RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
    	dispatcher.forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // add connection closed header
        response.setHeader("Connection", "close");
        
        // Create PrintWriter object to write to
        try {
            //FIXME:Atualizar o upload de arquivos para utilizar o MultiPartResolver da Spring. 
            String userId = request.getParameter("userId");
            String aplicacao = request.getParameter("aplicacao");
            Boolean isSubReport = new Boolean(request.getParameter("isSubReport"));
            MultipartRequest wrapper = (MultipartRequest) request;
            
            for (int i = 0; i < wrapper.getFiles("Filedata").size(); i++)
            {
                File file = (File) wrapper.getFiles("Filedata").get(i);
                String path = aplicacao + File.separator;
                
                File uploadDir = new File(path);
                uploadDir.mkdirs();
                
                File uploadFile = null;
//        		uploadFile = new File(uploadDir,wrapper.getFileNames("Filedata")[i]);
                
                Logger.getLogger(UploadServlet.class.getName()).log(Level.INFO, uploadFile.getAbsolutePath());
                
                FileOutputStream toFile = new FileOutputStream(uploadFile);
                DataInputStream fromClient = new DataInputStream(new FileInputStream(file));
    
                byte[] buff = new byte[1024];
                int cnt = 0;
                while ((cnt = fromClient.read(buff)) > -1) {
                    toFile.write(buff, 0, cnt);
                }
                toFile.flush();
                toFile.close();
                fromClient.close();

                if(!isSubReport && StringUtils.substringAfterLast(uploadFile.getName(),".").equalsIgnoreCase("jasper"))
                {
                    new ReportService().salvarReport(aplicacao, uploadFile,Long.parseLong(userId));
                }
            }

            response.getWriter().print("Arquivos enviados com sucesso!");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print(e.getLocalizedMessage());
        }
    }
}