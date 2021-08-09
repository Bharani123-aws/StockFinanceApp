package com.ucm.Stackmanagement.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ucm.Stackmanagement.StackPriceDetails;

public class StackDao {
	
	
	private  String jdbcURL="jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false";
	private  String jdbcUserName="root";
	private  String jdbcPassword="bh12";
	private  String jdbcDriver="com.mysql.jdbc.Driver";
	
	//private static final String getStackPriceDetails="Select * from companyname where Stock_Symbol=?";
	private static final String getStackPriceVolume="Select c.Company_Name,c.Stock_Symbol,E.Stock_ExchangeName,T.Start_TradingDate,T.End_TradingDate,"+
			"max(p.High) as High, max(p.Volume) as Volume"+" from companyname as c left join price as p on c.Stock_Symbol=p.Symbol"+" left join timeframe as T on T.Company_Symbol=c.Stock_Symbol"+
			" left join Exchangestock as E on E.Symbol=c.Stock_Symbol  where c.Stock_Symbol=?";
	
	
	private static final String  getStackAllDetails= " select Price_Open,Price_Close, TradingDate,Volume, Low, High, Company_Name,Stock_ExchangeName FROM (SELECT p.TradingDate,p.Price_Open,p.Volume,p.Price_Close,p.Low,p.High,e.Company_Name,e.Stock_ExchangeName" + 
			"   FROM  price p left join" + 
			"    exchangestock e on e.Symbol=p.Symbol" + 
			"    where  e.Symbol=?" + 
			" ORDER BY p.TradingDate  DESC LIMIT ?" + 
			" )Var1" + 
			"   ORDER BY TradingDate ASC;";
	
	private static final String  getStackDetailsByExchangeName= " select Price_Open,Price_Close, TradingDate,Volume, Low, High, Company_Name,Stock_ExchangeName FROM (SELECT p.TradingDate,p.Price_Open,p.Volume,p.Price_Close,p.Low,p.High,e.Company_Name,e.Stock_ExchangeName" + 
			"   FROM  price p left join" + 
			"    exchangestock e on e.Symbol=p.Symbol" + 
			"    where  e.Symbol=? and e. Stock_ExchangeName like ?" + 
			" ORDER BY p.TradingDate  DESC LIMIT ?" + 
			" )Var1" + 
			"   ORDER BY TradingDate ASC;";
	
	
	public StackDao() {}
	
	protected Connection getConnection() {
		
		Connection conn=null;
		try {
			Class.forName(jdbcDriver);
			conn= DriverManager.getConnection(jdbcURL, jdbcUserName, jdbcPassword);
			
			
		}
		catch(SQLException e) {
			
			e.printStackTrace();
		}catch(ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		
		return conn;
		
	}
	
	public List<StackPriceDetails> GetStackDetailsBySymbol(String stock_Symbol) 
	{
		List<StackPriceDetails> stack=new ArrayList<>();
		try(Connection cn=getConnection();
			
			PreparedStatement st= cn.prepareStatement(getStackPriceVolume);){
			
			st.setString(1, stock_Symbol);
			 ResultSet rs= st.executeQuery();
			 
			 while(rs.next()) {
				 
				 String symbol= rs.getString("stock_Symbol");
				 String companyName= rs.getString("Company_Name");
				 String exchangeName=rs.getString("Stock_ExchangeName");
				 Date sTradeDate=rs.getDate("Start_TradingDate");
				 Date eTradeDate=rs.getDate("End_TradingDate");
				 float highPrice= rs.getFloat("High");
				 int highVolume=rs.getInt("Volume");
				 
				 stack.add(new StackPriceDetails(companyName,symbol,exchangeName,sTradeDate,eTradeDate,highPrice,highVolume));
			 }
			
			 
			 
		}
		catch(SQLException e) {e.printStackTrace();}
		
		
		 return stack;
	}
	
	//Statistics
	public List<StackPriceDetails> GetAllStackDetails(String Symbol,int noOfRecords){
		List<StackPriceDetails> stack_Details=new ArrayList<>();
		try(Connection cn=getConnection();
			
			PreparedStatement st= cn.prepareStatement(getStackAllDetails);){
			
			st.setString(1, Symbol);
			st.setInt(2, noOfRecords);
			 ResultSet rs= st.executeQuery();
			 
			 int index=0;
			 while(rs.next()) {
				 
				  index= index+1;
				 Date tradeDate=rs.getDate("TradingDate");
				 float open= rs.getFloat("Price_Open");
				 int volume=rs.getInt("Volume");
				 float close=rs.getFloat("Price_Close");
				 float low=rs.getFloat("Low");
				 float high=rs.getFloat("High");
				 String companyName=rs.getString("Company_Name");
				 String exchangeName=rs.getString("Stock_ExchangeName");
				 
				 stack_Details.add(new StackPriceDetails(companyName,tradeDate,open,index,close,low,high,volume,exchangeName));
			 }
		}
		catch(SQLException e) {
			
			e.printStackTrace();
		}
		
		return stack_Details;
		
	}
	
	public List<StackPriceDetails> GetStackDetailsByExchangeName(String Symbol,int noOfRecords,String exchange){
		List<StackPriceDetails> stack_Details=new ArrayList<>();
		try(Connection cn=getConnection();
			
			PreparedStatement st= cn.prepareStatement(getStackDetailsByExchangeName);){
			
			st.setString(1, Symbol);
			st.setString(2, exchange);
			st.setInt(3,noOfRecords );
			 ResultSet rs= st.executeQuery();
			 
			 int index=0;
			 while(rs.next()) {
				 
				  index= index+1;
				 Date tradeDate=rs.getDate("TradingDate");
				 float open= rs.getFloat("Price_Open");
				 int volume=rs.getInt("Volume");
				 float close=rs.getFloat("Price_Close");
				 float low=rs.getFloat("Low");
				 float high=rs.getFloat("High");
				 String companyName=rs.getString("Company_Name");
				 String exchangeName=rs.getString("Stock_ExchangeName");
				 
				 stack_Details.add(new StackPriceDetails(companyName,tradeDate,open,index,close,low,high,volume,exchangeName));
			 }
		}
		catch(SQLException e) {
			
			e.printStackTrace();
		}
		
		return stack_Details;
		
	}
	
	
	
}
