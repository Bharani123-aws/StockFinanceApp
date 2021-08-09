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
 * Servlet implementation class PriceServlet
 */
@WebServlet("/PriceServlet")
public class PriceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StackDao stackDao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PriceServlet() {
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
		
		
		showPriceDetails(request,response);
		
	}
	
	private void showPriceDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String symbol= request.getParameter("symbol");
		
		
		try {
			
			List<StackPriceDetails> list= stackDao.GetStackDetailsBySymbol(symbol);
			
			request.setAttribute("listPriceDetails", list);


			if((request.getParameter("HighPrice") != null)&&(request.getParameter("HighVolume") != null)){
			    //checkbox  checked
				RequestDispatcher dispatcher = request.getRequestDispatcher("StackPriceVolumeDetails.jsp");
				dispatcher.forward(request, response);
			}
			else {
			
			if(request.getParameter("HighPrice") != null) {
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("StackPriceDetails.jsp");
				dispatcher.forward(request, response);
			}
			if(request.getParameter("HighVolume") != null) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("StackVolumeDetails.jsp");
				dispatcher.forward(request, response);
			}
			if((request.getParameter("HighPrice") == null)&&(request.getParameter("HighVolume") == null)){
			    //checkbox  checked
				RequestDispatcher dispatcher = request.getRequestDispatcher("StackPriceVolumeDetails.jsp");
				dispatcher.forward(request, response);
			}
			
			}
			
		}
		catch(Exception e) {
				e.printStackTrace();
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
