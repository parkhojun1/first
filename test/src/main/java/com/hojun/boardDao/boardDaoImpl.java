package com.hojun.boardDao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Repository
public class boardDaoImpl implements boardDao{
	
	@Autowired
	SqlSessionTemplate session;


	@Override
	public int getCnt(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return session.selectOne("hojun.getCnt", params);
	}


	@Override
	public List<HashMap<String, String>> getList(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return session.selectList("hojun.getList", params);
	}


	@Override
	public void setInsert(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		session.insert("hojun.setInsert", params);
		
	}


	@Override
	public HashMap<String, String> getContent(String indexno) {
		// TODO Auto-generated method stub
		return session.selectOne("hojun.getContent", indexno);
	}


	@Override
	public void setModify(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		session.update("hojun.setModify", params);
	}




	@Override
	public void setDelete(HashMap<String, Object> data) {
		// TODO Auto-generated method stub
		session.delete("hojun.setDelete",data);
	}


	@Override
	public int getRes(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		return session.selectOne("hojun.getRes",params);
	}

}
