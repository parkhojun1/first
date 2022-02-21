package com.hojun.boardDao;

import java.util.HashMap;
import java.util.List;

public interface boardDao {

	int getCnt(HashMap<String, String> params);

	List<HashMap<String, String>> getList(HashMap<String, String> params);

	void setInsert(HashMap<String, String> params);

	HashMap<String, String> getContent(String indexno);

	void setModify(HashMap<String, String> params);

	void setDelete(HashMap<String, Object> data);

	int getRes(HashMap<String, String> params);

}
