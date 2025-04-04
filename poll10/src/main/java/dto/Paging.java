package dto;

public class Paging {
	private int currentPage; 
	private int rowPerPage;

	
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	
	public int getLastPage(int totalRow) {
		int lastPage = totalRow/rowPerPage; 
		if( totalRow % rowPerPage !=0) {
			lastPage = lastPage+1;
		}
		return lastPage;
	}
	
	public int getBeginRow() {
		int beginRow = (currentPage-1)*rowPerPage;
		
		return beginRow;
	}
	
	
	
}
