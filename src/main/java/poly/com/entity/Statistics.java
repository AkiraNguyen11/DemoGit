package poly.com.entity;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Statistics")
public class Statistics {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "StatisticID")
    private Long statisticID;

    @Column(name = "Date")
    private Date date;

    @Column(name = "TotalSales")
    private double totalSales;

    @Column(name = "TotalOrders")
    private int totalOrders;

    @Column(name = "MostPopularProduct")
    private String mostPopularProduct;

	public Long getStatisticID() {
		return statisticID;
	}

	public void setStatisticID(Long statisticID) {
		this.statisticID = statisticID;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public double getTotalSales() {
		return totalSales;
	}

	public void setTotalSales(double totalSales) {
		this.totalSales = totalSales;
	}

	public int getTotalOrders() {
		return totalOrders;
	}

	public void setTotalOrders(int totalOrders) {
		this.totalOrders = totalOrders;
	}

	public String getMostPopularProduct() {
		return mostPopularProduct;
	}

	public void setMostPopularProduct(String mostPopularProduct) {
		this.mostPopularProduct = mostPopularProduct;
	}

    
}
