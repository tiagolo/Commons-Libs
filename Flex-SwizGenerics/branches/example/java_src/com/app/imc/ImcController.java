/**
 * 
 */
package com.app.imc;

import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author tiagolo
 *
 */
@Controller
public class ImcController {

	@RequestMapping("imc")
	public void calcularIMC(HttpServletRequest request,
            HttpServletResponse response) throws IOException
	{
		String peso = request.getParameter("peso");
		String altura = request.getParameter("altura");
		
		ServletOutputStream out = response.getOutputStream();
		
		out.print("<pre>");
		out.println(request.getParameterMap().toString());
		out.print("</pre>");
		out.println(peso + " " + altura);
		
		out.flush();
		out.close();
	}
	
}
