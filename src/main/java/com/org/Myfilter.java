/*package com.org;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebFilter("/chatwithme/*")
public class Myfilter implements Filter {

	
	
	@Override
	  public void doFilter(ServletRequest request, ServletResponse response,
	            FilterChain chain) throws IOException, ServletException {
		System.out.println("filter executed");
	        HttpServletRequest req = (HttpServletRequest) request;
	        HttpServletResponse res=(HttpServletResponse)response;
	        
	        HttpSession session=req.getSession();
	        
	        if( session.getAttribute("name")==null )
	        {
	        	
	        	System.out.println("inside chain invalid");
	        	res.sendRedirect("Web-INF/index.jsp");
	        	
	        }
	        else if( session.getAttribute("name").equals("active"))
	    		   {
	        	
	    		System.out.println("inside chain valid");
	            chain.doFilter(request, response);
	    		   }
	       else
	       {
	    	   System.out.println("inside chain else  invalid req");
                  res.sendRedirect("www.google.com");
                  
	       }
	       
	       }

	    @Override
	    public void destroy() {
	    }

	    @Override
	    public void init(FilterConfig arg0) throws ServletException {
	    }
	}
*/