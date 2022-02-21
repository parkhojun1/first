package com.hojun.boardController;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hojun.boardDto.PagingBean;
import com.hojun.boardService.IPagingService;
import com.hojun.boardService.boardService;

@Controller
public class boardController {
	
	@Autowired
	boardService service;
	
	@Autowired
	IPagingService paging;
	
	
	@RequestMapping(value="/modify")
	public ModelAndView modify(ModelAndView mv ,@RequestParam String indexno) {
		
		HashMap<String, String>  data =service.getContent(indexno);
		mv.addObject("data",data);
		mv.setViewName("modify");
		
		
		return mv;
	}
	
	
	@RequestMapping(value="/index")
	public ModelAndView index(ModelAndView mv) {
		mv.setViewName("index");
		
		
		return mv;
	}
	
	
	@RequestMapping(value="/left")
	public ModelAndView left(ModelAndView mv) {
		mv.setViewName("left");
		
		
		return mv;
	}
	
	@RequestMapping(value="/main")
	public ModelAndView main(ModelAndView mv, @RequestParam HashMap<String, String> params) {
		try {
			int page =1;
			if(params.get("page") != null) {
				page = Integer.parseInt(params.get("page"));
			}
			mv.addObject("page",page);
			mv.setViewName("main");
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return mv;
	}
	
	@RequestMapping(value="/insert")
	public ModelAndView insert(ModelAndView mv) {
		mv.setViewName("insert");
		return mv;
	}
	
	@RequestMapping(value="/listAjax")
	public @ResponseBody HashMap<String, Object> listAjax(@RequestParam HashMap<String, String> params) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		try {
		//현재페이지
		int page = Integer.parseInt((String) params.get("page"));
		//총게시글수
		int cnt = service.getCnt(params);
		//현재페이지 , 최대갯수
		PagingBean pb = paging.getPagingBean(page, cnt) ;
		//게시글 시작번호 , 종료 번호 할당
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));	
		//목록취득
		List<HashMap<String, String>> list
			=service.getList(params);
		data.put("startCnt", params.get("startCnt"));
		data.put("endCnt", params.get("startCnt"));
		data.put("list",list);
		data.put("pb", pb);
		data.put("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	
	@RequestMapping(value="/insertAjax")
	public @ResponseBody HashMap<String, Object> isnertAjax(@RequestParam HashMap<String, String> params) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		try {
			
			int res =service.getRes(params);
			if(res == 0) {
				service.setInsert(params);
			}
			data.put("result", res);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	
	@RequestMapping(value="/modifyAjax")
	public @ResponseBody HashMap<String, Object> modifyAjax(@RequestParam HashMap<String, String> params) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		try {
			int res =service.getRes(params);
			if(res == 0) {
			service.setModify(params);
			}
			data.put("result", res);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	
	@RequestMapping(value="/deleteAjax")
	public @ResponseBody HashMap<String, Object> deleteAjax(@RequestParam(value="check[]") List<Integer> list) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		try {
			data.put("list", list);
			service.setDelete(data);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
//	@RequestMapping(value = "/uploadExcel" ,method = {RequestMethod.POST})
//	@ResponseBody
//	public String uploadExcel(MultipartHttpServletRequest request){
//		MultipartFile file = null;
//		Iterator<String> iterator = request.getFileNames();
//		if(iterator.hasNext()) {
//			file = request.getFile(iterator.next());
//		}
//
//		// 엑셀 헤더 정보 구성
//		String[] headerInfo = {"number", "text", "date"};
//
//		// 엑셀 파일을 읽어 데이터 가져오기
//		List<HashMap<String, Object>> list = excelUtil.uploadExcel(file, headerInfo);
//
//		return list;
//	}
	
	
	


}
