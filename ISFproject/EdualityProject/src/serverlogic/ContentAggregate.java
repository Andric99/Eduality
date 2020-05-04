package serverlogic;

import java.util.ArrayList;

public class ContentAggregate extends AggregateBase {

	
	//I create the structure for my content
	private ArrayList<Content> allContent = new ArrayList<>();
	
	
	public ContentIterator createIterator() {
		
		return new ContentIterator(this);	
	}
	
	public void addItem(Content content) {
		//CAUTION I'm not doing addItem() I am using 
		// the add() from the structure that I've choosen
		allContent.add(content);
	}
	
	public int count() {
		return allContent.size();
	}
	
	public Content obtain(int position) {
		return allContent.get(position);
	}
	
	
	
}
