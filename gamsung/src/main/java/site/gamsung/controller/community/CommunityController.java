package site.gamsung.controller.community;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import site.gamsung.service.common.Page;
import site.gamsung.service.common.RatingReviewService;
import site.gamsung.service.common.Search;
import site.gamsung.service.community.CommunityService;
import site.gamsung.service.domain.AuctionProduct;
import site.gamsung.service.domain.Camp;
import site.gamsung.service.domain.Comment;
import site.gamsung.service.domain.Post;
import site.gamsung.service.domain.RatingReview;
import site.gamsung.service.domain.User;

@RequestMapping("/community/*")
@Controller
public class CommunityController {

   @Value("#{commonProperties['communityPageSize']}")
   int communityPageSize;

   @Autowired
   @Qualifier("communityServiceImpl")
   private CommunityService communityService;
   
   @Autowired
   @Qualifier("campRatingReviewServiceImpl")
   private RatingReviewService ratingReviewService;
   
   
   
   @Value("#{commonProperties['pageUnit']}")
   int pageUnit;
   

   public CommunityController() {
      System.out.println(this.getClass());
   }

// ???????????? List navigation  
   @RequestMapping(value = "listPost")
   public String listPost(@ModelAttribute("search") Search search,
         @RequestParam(value = "postType", required = false) String postType, Model model, HttpSession session)
         throws Exception {

      System.out.println("listPost"); // listPost ??????
      System.out.println(postType);
      System.out.println(search);

      User user = (User) session.getAttribute("user"); // Session?????? user????????? user setting??????.

      System.out.println(user);

      if (user == null) {
         return "redirect:/";
      } // user??? null?????? main?????? navigation

      search.setPageSize(communityPageSize);

      // System.out.println(search);

      if (search.getCurrentPage() == 0) {
         search.setCurrentPage(1);
      }

      System.out.println(search);
      // ????????? ????????? commonProperties??? ?????? ????????????, 1???????????? ??????????????? ????????????.

      HashMap<String, Object> map = new HashMap<String, Object>();

      Post post = new Post();

      if (postType != null) {

         int postTypee = Integer.parseInt(postType);
         post.setPostType(postTypee);

      }
      map.put("userId", user.getId());
      map.put("search", search);
      map.put("post", post);

      // System.out.println(map);
      List<Post> list = communityService.listPost(map);

      System.out.println("list::::::" + list);
      // Model ??? View ??????

      model.addAttribute("list", list);
      model.addAttribute("userId", user.getId());
      model.addAttribute("search", search);

      return "forward:/view/community/listPost.jsp";

   }

   // ????????? ?????? ????????? navigation
   @GetMapping(value = "addPost")
   public String addPost(HttpSession session, Model model) {

      System.out.println("addPost Get Start");

      // ???????????? ?????? ????????? ????????? ????????? ????????????.
      User user = (User) session.getAttribute("user");

      if (user == null) {
         return "redirect:/";
      }

      return "redirect:/view/community/addPost.jsp";
   }

   // ????????? ?????? Mapping

   @RequestMapping(value = "addPost", method = RequestMethod.POST) // RequestParam??? ????????? file type????????? name??? ?????????.
   public String addPost(@ModelAttribute("post") Post post, @RequestParam("postImg") MultipartFile[] postImg,
         HttpServletRequest req, HttpSession session, Model model) throws Exception {
      
      System.out.println("addPost Post Start");
      
      System.out.println("----------------\n"
                      	+"???     data     ???\n"
                      	+"----------------\n"+post);
      
      RatingReview ratingReview = null;
      
//      Camp camp = new Camp(); // camp ?????????
//      int campno = post.getCampNo(); // addPost?????? ????????? campNo ????????????.
//      camp.setCampNo(campno); // campno camp??? setting

//      if (campno != 0 && post.getStatusRating() != 0) { // ?????? ?????? ??????

      int index = 1;

      for (MultipartFile multpartfile : postImg) {

         // MultipartFile??? ?????? postImg?????? file????????? originalPostImg??? ?????????.
         String originalPostImg = multpartfile.getOriginalFilename();

         System.out.println("originalPostImg::::" + originalPostImg + "!");

         if (originalPostImg != null && originalPostImg != "") {

            // ??? ????????? .??? ????????? ???????????? ????????? ???????????? ?????? (ex .jsp)
            String originalFileExtension = originalPostImg.substring(originalPostImg.lastIndexOf("."));

            // UUID??? ???????????? ??????????????? -??? ????????? ????????? ???????????? ?????? (ex 359498a2ff1a40b8a8e16f6c43dd2bf3.jpg)
            String root_path = req.getSession().getServletContext().getRealPath("/");
            String attach_path = "uploadfiles/community/img/";

            String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;

            System.out.println(root_path);
            // File??? ???????????? ????????? ?????? ?????? ??????????????? ?????????.
            File file = new File(root_path + attach_path + storedFileName);
            
            System.out.println("file::::" + file);
            
            // MultipartFile.transferTo(File file) - Byte????????? ???????????? File????????? ????????? ?????? ????????? ????????????.
            // file?????? ????????? ???????????? ??????????????? ??????. ?????? PostImg??? ?????????.
            multpartfile.transferTo(file); // postImg??? transferto(?????????)file???
            
            System.out.println("file");
            System.out.println("file.getPath::" + file.getPath()+"\n");
            
            
            if(post.getPostType() == 4 && post.getCampNo() != 0 ) {
               
               System.out.println("--------------------------------\n??? review File save starting.... ??? \n--------------------------------");
               
               attach_path = "uploadfiles/campimg/review/";
               System.out.println("File storage path!! \n ==> "+root_path + attach_path + storedFileName);
               file = new File (root_path + attach_path + storedFileName);
               multpartfile.transferTo(file);
            }
            
            System.out.println("file");
            System.out.println("file.getPath::" + file.getPath());
            
            if (index == 1) {
               post.setPostImg1(storedFileName);
            } else if (index == 2) {
               post.setPostImg2(storedFileName);
            } else {
               post.setPostImg3(storedFileName);
            }
            
            index++;
         } // originalPostImg if??? END

      } // postImg for??? END

      User user = (User) session.getAttribute("user");
      post.setWriter(user);

      if(post.getPostType() == 4 && post.getCampNo() != 0 ) {
         Camp camp = new Camp();
         camp.setCampNo(post.getCampNo());
         
         ratingReview = new RatingReview(camp, user, 2, post.getPostTitle(), post.getPostContent(), post.getStatusRating(), post.getPostImg1(), post.getPostImg2(), post.getPostImg3());
         
         ratingReviewService.addRatingReview(ratingReview);
      }
      
      communityService.addPost(post);
      

      return "redirect:/community/listPost";
//      return "forward:/campGeneral/addCampRatingReview";

   }// ?????? method ??????

   // ????????? ?????? page navigation
   @GetMapping(value = "updatePost")
   public String updatePost(@RequestParam String postNo, HttpSession session, Post post, Model model)
         throws Exception { // throw Exception??? ????????? ?????? ???????

      System.out.println("updatePost Get Start");

      // ???????????? ?????? ????????? ????????? ????????? ????????????.
      User user = (User) session.getAttribute("user");

      if (user == null) {
         return "redirect:/";
      }

      int postno = Integer.parseInt(postNo);

      post = communityService.getPost(postno);

      model.addAttribute("post", post);
      model.addAttribute("user", user);

      return "forward:/view/community/updatePost.jsp";
   }

   // ????????? ?????? ??????????????????
   @PostMapping(value = "updatePost")
   public String updatePost(@ModelAttribute("post") Post post, @RequestParam("postImg") MultipartFile[] postImg,
         HttpServletRequest req, HttpSession session) throws Exception { // throw Exception??? ????????? ?????? ???????

      System.out.println("updatePost Post Start");

      // ???????????? ?????? ????????? ????????? ????????? ????????????.
      User user = (User) session.getAttribute("user");

//      String PostContent = post.getPostContent();   
      System.out.println(post);

      if (user == null) {
         return "redirect:/";

      }

      int index = 1;

      for (MultipartFile multpartfile : postImg) {

         // MultipartFile??? ?????? postImg?????? file????????? originalPostImg??? ?????????.
         String originalPostImg = multpartfile.getOriginalFilename();

         System.out.println("originalPostImg::::" + originalPostImg + "!");

         if (originalPostImg != null && originalPostImg != "") {

            // ??? ????????? .??? ????????? ???????????? ????????? ???????????? ?????? (ex .jsp)
            String originalFileExtension = originalPostImg.substring(originalPostImg.lastIndexOf("."));

            // UUID??? ???????????? ??????????????? -??? ????????? ????????? ???????????? ?????? (ex 359498a2ff1a40b8a8e16f6c43dd2bf3.jpg)
            String root_path = req.getSession().getServletContext().getRealPath("/");
            String attach_path = "uploadfiles/community/img/";
            String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;

            System.out.println(root_path);
            // File??? ???????????? ????????? ?????? ?????? ??????????????? ?????????.
            File file = new File(root_path + attach_path + storedFileName);

            System.out.println("file::::" + file);

            // MultipartFile.transferTo(File file) - Byte????????? ???????????? File????????? ????????? ?????? ????????? ????????????.
            // file?????? ????????? ???????????? ??????????????? ??????. ?????? PostImg??? ?????????.
            multpartfile.transferTo(file); // postImg??? transferto(?????????)file???

            System.out.println("file");
            System.out.println("file.getPath::" + file.getPath());

            if (index == 1) {
               post.setPostImg1(storedFileName);
            } else if (index == 2) {
               post.setPostImg2(storedFileName);
            } else {
               post.setPostImg3(storedFileName);
            }

            index++;
         }
      }

      post.setWriter(user);
      
      System.out.println("\n\n Post ==> " + post);

      communityService.updatePost(post);

      return "redirect:listPost";
   }

   // ????????? ??????
   @GetMapping(value = "deletePost")
   public String deletePost(@RequestParam("postNo") int postNo, HttpSession session) throws Exception { // throw
                                                                                 // Exception???
                                                                                 // ????????? ??????
                                                                                 // ???????
      System.out.println("deletePost Post Start");

      
      System.out.println("postNo ==> " + postNo);
      
      
      // ???????????? ?????? ????????? ????????? ????????? ????????????.
      User user = (User) session.getAttribute("user");

      if (user == null) {
         return "redirect:/";

      }

      communityService.deletePost(postNo);

      return "redirect:listPost";
   }
   
// ???????????? My post navigation  
   
   @RequestMapping(value = "listMyPost")
   public String listMyPost(@ModelAttribute("search") Search search, @RequestParam(value = "postType", required = false) String postType, Model model, HttpSession session) throws Exception {

      System.out.println("listMyPost"); // listPost ??????
      System.out.println(postType);
      System.out.println(search);

      User user = (User) session.getAttribute("user"); // Session?????? user????????? user setting??????.

      System.out.println(user);

      if (user == null) {
         return "redirect:/";
      } // user??? null?????? main?????? navigation

      search.setPageSize(communityPageSize);

      // System.out.println(search);

      if (search.getCurrentPage() == 0) {
         search.setCurrentPage(1);
      }

      HashMap<String, Object> map = new HashMap<String, Object>();

      Post post = new Post();

      if (postType != null) {
        int postTypee = Integer.parseInt(postType);
         post.setPostType(postTypee);
      }
      map.put("userId", user.getId());
      map.put("search", search);
      map.put("post", post);

      // System.out.println(map);
      List<Post> list = communityService.listPost(map);
      int totalCount = communityService.getTotalPost(map);
      
      Page resultPage = new Page( search.getCurrentPage(), totalCount, pageUnit, communityPageSize);
      
      System.out.println("list::::::" + list);

      model.addAttribute("list", list);
      model.addAttribute("resultPage", resultPage); 
      model.addAttribute("search",search);
      
      return "forward:/view/community/listMyPost.jsp";

   }

// ???????????? My comment List navigation  
   
   @RequestMapping(value = "listMyComment")
   public String listMyComment(@ModelAttribute("search") Search search, @RequestParam(value = "postType", required = false) String postType, Model model, HttpSession session) throws Exception {
  
	  System.out.println("listMyComment"); 
      User user = (User) session.getAttribute("user"); // Session?????? user????????? user setting??????.

      if (user == null) {
         return "redirect:/";
      } // user??? null?????? main?????? navigation
      search.setPageSize(communityPageSize);

      if (search.getCurrentPage() == 0) {
         search.setCurrentPage(1);
      }
      
      search.setId(user.getId());

      // System.out.println(map);
      List<Post> list = communityService.listPostForComment(search);//?????? List		(map);
      int totalCount = communityService.getTotalComment(search);
      
      System.out.println("listPostForCommentlist::::::" + list);
      
      Page resultPage = new Page( search.getCurrentPage(), totalCount, pageUnit, communityPageSize);
      
      model.addAttribute("list", list);
      model.addAttribute("resultPage",resultPage);
      
      return "forward:/view/community/listMyComment.jsp";

   }

   // ????????? ??????
   @GetMapping(value = "getPost")
   public String getPost(@RequestParam("postNo") int postNo, HttpSession session, Model model) throws Exception { // throw
                                                                                                                                 
      System.out.println("getPost Post Start");

      User user = (User) session.getAttribute("user");

      if (user == null) {
         return "redirect:/";

      }

      Post post = communityService.getPost(postNo);
      
      model.addAttribute("post", post);
      
      return "forward:/view/community/getPost.jsp";
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   

}