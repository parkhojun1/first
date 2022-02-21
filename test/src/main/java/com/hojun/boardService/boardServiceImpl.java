package com.hojun.boardService;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hojun.boardDao.boardDao;

@Service
public class boardServiceImpl implements boardService{
	
	
	@Autowired
	boardDao dao;

	@Override
	public int getCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return dao.getCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return dao.getList(params);
	}

	@Override
	public void setInsert(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		dao.setInsert(params);
		
	}

	@Override
	public HashMap<String, String> getContent(String indexno) {
		// TODO Auto-generated method stub
		return dao.getContent(indexno);
	}

	@Override
	public void setModify(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		dao.setModify(params);
	}




	@Override
	public void setDelete(HashMap<String, Object> data) {
		dao.setDelete(data);
		
	}

	@Override
	public int getRes(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return dao.getRes(params);
	}

}
