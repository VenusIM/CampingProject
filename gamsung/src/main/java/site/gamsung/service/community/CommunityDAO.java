package site.gamsung.service.community;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import site.gamsung.service.common.Search;
import site.gamsung.service.domain.Comment;
import site.gamsung.service.domain.Post;
import site.gamsung.service.domain.User;

public interface CommunityDAO {
	
	//게시물
	
	public int addPost(Post post)throws Exception;
	
	public List<Post> ListPost(Post post)throws Exception;
	
	public Post getPost(int postNo)throws Exception;

	public int updatePost(Post post)throws Exception;
	
	public int deletePost(int postNo)throws Exception;
	
	//댓글

	public int addComment(Comment comment)throws Exception;
	
	public List<Comment> listComment(int postNo)throws Exception;
	
	public int updateComment(Comment comment)throws Exception;
	
	public int deleteComment(int CommentNo)throws Exception;
	
	//추천
	
	public int updateConcern(HashMap<String,Object> Map) throws Exception ;
	

}
