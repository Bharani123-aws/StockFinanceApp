package com.ucm.Stackmanagement.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ucm.Stackmanagement.StackPriceDetails;
import com.ucm.Stackmanagement.dao.StackDao;

/**
 * Servlet implementation class Statistics
 */
@WebServlet("/Statistics")
public class Statistics extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StackDao stackDao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Statistics() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		stackDao = new StackDao();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		GetAllExchangeDetails(request,response);
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	
	 private void  GetAllExchangeDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
		 
		 int index=Integer.parseInt(request.getParameter("Top"));
		 String exchange=request.getParameter("exchange");
		 String symbol=request.getParameter("symbol");
		 
		 try {
			 if(exchange.equals("ALL")) {
			 List<StackPriceDetails> list= stackDao.GetAllStackDetails(symbol, index);
			 request.setAttribute("listExchange", list);
			 
			 RequestDispatcher dispatcher = request.getRequestDispatcher("StackExchangeDetails.jsp");
				dispatcher.forward(request, response);	 
			 
			 
			 }
			 else {
				 List<StackPriceDetails> list= stackDao.GetStackDetailsByExchangeName(symbol, index,exchange);
				 request.setAttribute("listExchange", list);
				 
				 RequestDispatcher dispatcher = request.getRequestDispatcher("StackExchangeDetails.jsp");
					dispatcher.forward(request, response);	
				 
				 
			 }
		 }
		 catch(Exception e) {
			 
			 e.printStackTrace();
			 
		 }
		 
		 
	 }
	
	
	
	
	

}
