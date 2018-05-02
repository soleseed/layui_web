package hansuo.portalwifi.base;

import java.util.List;

/**
 * 自定义简易树
 * @author Administrator
 *
 */
public class Tree {

	private String name;
	private List<Tree> children;
	
	public List<Tree> getChildren() {
		return children;
	}
	public void setChildren(List<Tree> children) {
		this.children = children;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
	
}
