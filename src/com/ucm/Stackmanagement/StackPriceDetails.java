package com.ucm.Stackmanagement;

import java.sql.Date;

public class StackPriceDetails {

	private String companyName;
	private String stock_Symbol;
	private String exchangeName;
	private Date startTradingDate;
	private Date endTradingDate;
	private float maxPrice;
	private int maxVolumne;
	
	public StackPriceDetails(String companyName, String stock_Symbol, String exchangeName, Date startTradingDate,
			Date endTradingDate, float maxPrice, int maxVolumne) {
		super();
		this.companyName = companyName;
		this.stock_Symbol = stock_Symbol;
		this.exchangeName = exchangeName;
		this.startTradingDate = startTradingDate;
		this.endTradingDate = endTradingDate;
		this.maxPrice = maxPrice;
		this.maxVolumne = maxVolumne;
	}
	
	
	public StackPriceDetails(String companyName, String stock_Symbol) {
		super();
		this.companyName = companyName;
		this.stock_Symbol = stock_Symbol;
	}
	
	
	//statistics
		
		public StackPriceDetails(String companyName, Date tradingDate, float open, int index, float close, float low,
				float high,int volume, String exchangeName) {
			super();
			this.companyName = companyName;
			this.tradingDate = tradingDate;
			this.open = open;
			this.index = index;
			this.close = close;
			this.low = low;
			this.high = high;
			this.maxVolumne=volume;
			this.exchangeName=exchangeName;
		}
		

	public float getPercentage() {
		return percentage;
	}


	public void setPercentage(float percentage) {
		this.percentage = percentage;
	}







	//statistics
	private Date tradingDate;
	private float open;
	
	// pie chart
	
	private float percentage;
	


	public int getIndex() {
		return index;
	}


	public void setIndex(int index) {
		this.index = index;
	}

	private int index;
	public Date getTradingDate() {
		return tradingDate;
	}


	public void setTradingDate(Date tradingDate) {
		tradingDate = tradingDate;
	}


	public float getOpen() {
		return open;
	}


	public void setOpen(float open) {
		this.open = open;
	}


	public float getClose() {
		return close;
	}


	public void setClose(float close) {
		this.close = close;
	}


	public float getLow() {
		return low;
	}


	public void setLow(float low) {
		this.low = low;
	}


	public float getHigh() {
		return high;
	}


	public void setHigh(float high) {
		this.high = high;
	}

	private float close;
	private float low;
	private float high;
	
	
	public String getCompanyName() {
		return companyName;
	}
	
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getStock_Symbol() {
		return stock_Symbol;
	}
	public void setStock_Symbol(String stock_Symbol) {
		this.stock_Symbol = stock_Symbol;
	}
	public String getExchangeName() {
		return exchangeName;
	}
	public void setExchangeName(String exchangeName) {
		this.exchangeName = exchangeName;
	}
	public Date getStartTradingDate() {
		return startTradingDate;
	}
	public void setStartTradingDate(Date startTradingDate) {
		this.startTradingDate = startTradingDate;
	}
	public Date getEndTradingDate() {
		return endTradingDate;
	}
	public void setEndTradingDate(Date endTradingDate) {
		this.endTradingDate = endTradingDate;
	}
	public float getMaxPrice() {
		return maxPrice;
	}
	public void setMaxPrice(float maxPrice) {
		this.maxPrice = maxPrice;
	}
	public int getMaxVolumne() {
		return maxVolumne;
	}
	public void setMaxVolumne(int maxVolumne) {
		this.maxVolumne = maxVolumne;
	}
	
	
	
}
