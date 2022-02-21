<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<link href="resources/css/style.css" rel="stylesheet" type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
let str ="";

	$(document).ready(function() {

	

	});//document ready
	
	

	
	
	function fileUploadCheck(obj , kind){
		
	    pathpoint = obj.value.lastIndexOf('.');
	    filepoint = obj.value.substring(pathpoint+1,obj.length);
	    filetype = filepoint.toLowerCase();
	    
	    
	    if(kind == 'image'){
		    if(filetype=='jpg') {
				setImageFromFile(obj, '#preview');
				var dd = document.getElementsByName("file")[0].value
				var result = 0;
				for (var i = 0; dd.indexOf('\\', i) != -1; i++) {
						result = dd.substr(dd.indexOf('\\', i) + 1);
				}
				$("input[name=imgname]").val(result);
		    } else {
		    	  alert('jpg 파일만 선택할 수 있습니다.');
		    	  obj.outerHTML = obj.outerHTML;
		    	  $("input[name=imgname]").val('');
		    	  $(".box").html('<img style="height: 110; width: 100" id="preview"></img>');	    	 
		    }  	
	    }
	    
	    if(kind =='excel'){
		    	if(filetype=='xls' || filetype=='xlsx') {
				var dd = document.getElementsByName("excelFile")[0].value
				var result = 0;
				for (var i = 0; dd.indexOf('\\', i) != -1; i++) {
						result = dd.substr(dd.indexOf('\\', i) + 1);
				}
				$("input[name=excelname]").val(result);
		    } else{
		    	alert('xls, xlsx 파일만 선택할 수 있습니다.');
		    	 $("input[name=excelname]").val('');
		    }
	    }
	    if(kind =='word'){
		    if(filetype=='docx'){
				var dd = document.getElementsByName("wordFile")[0].value
				var result = 0;
				for (var i = 0; dd.indexOf('\\', i) != -1; i++) {
						result = dd.substr(dd.indexOf('\\', i) + 1);
				}
				$("input[name=wordname]").val(result);
		    } else{
		    	alert('doc 파일만 선택할 수 있습니다.');
		    	 $("input[name=wordname]").val('');
		    }
	    }       	    
	}
	

	

	//주민번호 입력시 생일 
	function birth(){
		if($("input[name=resno1]").val().length >= 6){
			var birth1 =$("input[name=resno1]").val().substr(0, 2);
			var birth2 =$("input[name=resno1]").val().substr(2, 2);
			var birth3 =$("input[name=resno1]").val().substr(4, 2);
			
			if('0' == $("input[name=resno1]").val().substr(0, 1)){
				$("input[name=birth1]").val("20"+birth1);
				$("input[name=birth2]").val(birth2);
				$("input[name=birth3]").val(birth3);
			}else{
				for(var i=1; i<=9; i++){
					if(i == $("input[name=resno1]").val().substr(0, 1)){
						$("input[name=birth1]").val("1"+i+birth1);
						$("input[name=birth2]").val(birth2);
						$("input[name=birth3]").val(birth3);
					}
				}
			}
		}
	}
	
	

	
	function kor(){
		var StringCheck = /^[a-zA-Zㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$/;
		if(!StringCheck.test($("input[name=korname]").val())){
			var html =" ※ 문자만 입력 가능합니다";
			$("span").html(html);
		}else{
			$("span").html("");
		}
	}
	
	
	

	//이미지미리보기
	function setImageFromFile(input, expression) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$(expression).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	function fileSearch(kind) {
		$(kind).click();
	}

	function insert() {
		var StringCheck = /^[a-zA-Zㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$/;
		var NumCheck = /^[0-9]*$/;
		
		if(confirm("등록 하시겠습니까?")){
				if (!StringCheck.test($("input[name=korname]").val()) || $("input[name=korname]").val() == '') {
					alert("한글이름에는 숫자를 입력할수없습니다")
					return;
				}else if(!StringCheck.test($("input[name=engname]").val()) || $("input[name=engname]").val() == '') {
					alert("영어이름에는 숫자를 입력할수없습니다")
					return;
				}else if(!StringCheck.test($("input[name=chnname]").val()) || $("input[name=chnname]").val() == '') {
					alert("한문이름에는 숫자를 입력할수없습니다")
					return;
				}
				
				else if(!NumCheck.test($("input[name=resno1]").val()) || $("input[name=resno1]").val() == '') {
					alert("주민등록번호에는 숫자만입력해주세요")
					return;
				}else if(!NumCheck.test($("input[name=resno2]").val()) || $("input[name=resno2]").val() == '') {
					alert("주민등록번호에는 숫자만입력해주세요")
					return;
				}else if(!NumCheck.test($("input[name=birth1]").val()) || $("input[name=birth1]").val() == '') {
					alert("생년월일에는 숫자만입력해주세요")
					return;
				}else if(!NumCheck.test($("input[name=birth2]").val()) || $("input[name=birth2]").val() == '') {
					alert("생년월일에는 숫자만입력해주세요")
					return;
				}else if(!NumCheck.test($("input[name=birth3]").val()) || $("input[name=birth3]").val() == '') {
					alert("생년월일에는 숫자만입력해주세요")
					return;
				}else if(!NumCheck.test($("input[name=year]").val()) || $("input[name=year]").val() == '') {
					alert("연차에는 숫자만입력해주세요")
					return;
				}else if(!NumCheck.test($("input[name=phoneno1]").val()) || $("input[name=phoneno1]").val() == '') {
					alert("전화번호에는 숫자만입력해주세요")
					return;
				}else if(!NumCheck.test($("input[name=phoneno2]").val()) || $("input[name=phoneno2]").val() == '') {
					alert("전화번호에는 숫자만입력해주세요")
					return;
				}else if(!NumCheck.test($("input[name=phoneno3]").val()) || $("input[name=phoneno3]").val() == '') {
					alert("전화번호에는 숫자만입력해주세요")
					return;
				}else if(!StringCheck.test($("input[name=grade]").val()) || $("input[name=grade]").val() == '') {
					alert("기술등급에는 숫자를 입력할수없습니다")
					return;
				}else{		
						if ($("#file").val() != '' || $("#excelfile").val() != '' || $("#wordfile").val() != '') {
							fileUpload();
						} else {
							insertUpload();
						}
				}		
		}
	}

	function fileUpload() {
		var form = new FormData(document.getElementById('fileForm'));
		$.ajax({
			url : "/fileUploadAjax", //컨트롤러 URL
			data : form,
			dataType : 'json',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(res) {
						if(res.fileName.length > 0){

							for(var i=0; i <=res.fileName.length -1; i++){
							    pathpoint = res.fileName[i].lastIndexOf('.');
							    filepoint = res.fileName[i].substring(pathpoint+1,res.fileName[i].length);
							    filetype = filepoint.toLowerCase();
								    
							    switch(filetype) {
								    case 'jpg' : $("input[name=imglocal]").val(res.fileName[i]);
								         break;
								    case 'xls': $("input[name=excellocal]").val(res.fileName[i]);
								         break;
								    case 'docx': $("input[name=wordlocal]").val(res.fileName[i]);
							         	break;
								}
							}
							insertUpload();
						}else{
							insertUpload();
						}				
			},
			error : function(jqXHR) {
				alert(jqXHR.responseText);
			}
		});
	}

	function insertUpload(){
	    var params = $("#insertForm").serialize();
	    // ajax 통신
	    $.ajax({
	        type : "POST",            // HTTP method type(GET, POST) 형식이다.
	        url : "/insertAjax",      // 컨트롤러에서 대기중인 URL 주소이다.
	        data : params, 
	        dataType : "json",// Json 형식의 데이터이다.
	        success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
	        	
	        	if(res.result == 0){
	           $("#insertForm").attr("action","index");
	           $("#insertForm").submit()
	        	} else if(res.result > 0 ){
	        		alert("동일한 주민등록번호가 등록되어 있습니다");
	        	}
	        },
	        error : function(request, status, error){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	        }
	    });
	}
	
	
	


</script>
</head>
<body topmargin="0" leftmargin="0">
	<form action="#" id="fileForm" enctype="multipart/form-data" style="display:none"
		method="post" >
		<input type="file" class="file" name="file" id="file" onchange="fileUploadCheck(this ,'image')" >
		<input type="file" id="excelFile" name="excelFile" onchange="fileUploadCheck(this ,'excel')" >
		<input type="file" id="wordFile" name="wordFile" onchange="fileUploadCheck(this ,'word')" >
	</form>

	
	<form action="#" id="insertForm">
		<input type="hidden" name="imglocal" >
		<input type="hidden" name="excellocal" >
		<input type="hidden" name="wordlocal" >
		<table width="640" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="640">&nbsp;</td>
			</tr>
			<tr>
				<td height="25"><img src="resources/image/icon.gif" width="9"
					height="9" align="absmiddle"> <strong>사원 기본 정보 수정</strong></td>
			</tr>
			<tr>
				<td><table width="640" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td height="15" align="left"><table width="640" border="0"
									cellspacing="0" cellpadding="0">
									<tr>
										<td><table width="640" border="0" cellspacing="1"
												cellpadding="0">
												<tr>
													<td height="2" background="resources/image/bar_bg1.gif"></td>
												</tr>
												<tr align="center" bgcolor="F8F8F8">
													<td height="26" align="center" bgcolor="#E4EBF1"
														style="padding-right: 10"><table width="600"
															border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td align="center"><strong>교육정보 | 자격증.
																		보유기술정보 | 프로젝트 정보 |경력정보 | 근무정보</strong></td>
															</tr>
														</table></td>
												</tr>
												<tr align="center" bgcolor="F8F8F8">
													<td height="3" align="right"
														background="resources/image/bar_bg1.gif"></td>
												</tr>
											</table></td>
									</tr>
								</table></td>
						</tr>
						<tr>
							<td height="6" align="center" valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td height="7" align="center" valign="top"><table
									width="600" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td bgcolor="#CCCCCC"><table width="600" border="0"
												cellspacing="1" cellpadding="0">
												<tr>
													<td height="135" align="center" bgcolor="#E4EBF1"><table
															width="600" border="0" cellpadding="0" cellspacing="0">
															<tr>
																<td width="144" height="119" align="center"><table
																		width="100" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td height="112" bgcolor="#CCCCCC"><table
																					width="100" border="0" cellspacing="1"
																					cellpadding="0">
																					<tr>
																						<td height="110" bgcolor="#FFFFFF" class="box"><img
																							style="height: 110; width: 100" id="preview"></img></td>
																					</tr>
																				</table></td>
																		</tr>
																	</table></td>
																<td width="456"><table width="423" border="0"
																		cellspacing="2" cellpadding="0">
																		<tr>
																			<td height="2" colspan="2"></td>
																		</tr>
																		<tr>
																			<td width="107" height="26" align="right"><strong>한글이름
																					:</strong>&nbsp;</td>
																			<td width="310" height="26"><input type="text" id=""
																				name="korname" onkeyup="kor()"><span style="color:red;"></span></td>
																			
																		</tr>
																		<tr>
																			<td height="26" align="right"><strong>영문이름
																					:&nbsp;</strong></td>
																			<td height="26"><input type="text"
																				name="engname"></td>
																		</tr>
																		<tr>
																			<td height="26" align="right"><strong>한문이름:</strong>&nbsp;</td>
																			<td height="26"><input type="text"
																				name="chnname"></td>
																		</tr>
																		<tr>
																			<td height="26" align="right"><strong>주민등록번호
																					:</strong>&nbsp;</td>
																			<td height="26"><input name="resno1" type="text" onkeyup="birth()"
																				size="15"> - <input name="resno2"
																				type="text" size="15"></td>
																		</tr>
																	</table></td>
															</tr>
														</table></td>
												</tr>
											</table></td>
									</tr>
								</table></td>
						</tr>
						<tr>
							<td height="7" align="center" valign="top">&nbsp;</td>
						</tr>
						<tr>
							<td height="13" align="center"><table width="600" border="0"
									cellspacing="0" cellpadding="0">
									<tr>
										<td bgcolor="#CCCCCC"><table width="600" border="0"
												cellspacing="1" cellpadding="0">
												<tr>
													<td bgcolor="#E4EBF1"><table width="526" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="102" align="right"><strong>사진파일명
																		:&nbsp;</strong></td>
																<td width="268"><input name="imgname" type="text"
																	size="40"></td>
																<td width="146"><font color="#FF0000"><img
																		src="resources/image/bt_search.gif"
																		onclick="fileSearch('#file')" width="49" height="18"></font></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="526" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="102" align="right"><strong>엑셀파일명
																		:&nbsp;</strong></td>
																<td width="268"><input name="excelname" type="text"
																	size="40"></td>
																<td width="146"><font color="#FF0000"><img
																		src="resources/image/bt_search.gif"
																		onclick="fileSearch('#excelFile')" width="49" height="18"></font></td>
															</tr>
														</table></td>
												</tr>
												
												<tr>
												<td bgcolor="#E4EBF1"><table width="526" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="102" align="right"><strong>워드파일명
																		:&nbsp;</strong></td>
																<td width="268"><input name="wordname" type="text"
																	size="40"></td>
																<td width="146"><font color="#FF0000"><img
																		src="resources/image/bt_search.gif"
																		onclick="fileSearch('#wordFile')" width="49" height="18"></font></td>
															</tr>
														</table></td>
												</tr>
												
												
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="102" align="right"><strong>생년월일
																		:&nbsp;</strong></td>
																<td width="391"><input name="birth1" type="text" 
																	size="10"> 년 <input name="birth2" type="text"
																	size="7"> 월 <input name="birth3" type="text"
																	size="7"> 일 ( <input type="radio"
																	name="birthlunar" value="1"> 양력 <input
																	type="radio" name="birthlunar" value="2"> 음력 )</td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="102" align="right"><strong>성별
																		:&nbsp; </strong></td>
																<td width="391"><input type="radio" name="gender"
																	value="1"> 남자 <input type="radio" name="gender"
																	value="2"> 여자</td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="102" align="right"><strong>결혼유무
																		:&nbsp;</strong></td>
																<td width="391"><input type="radio" name="marry"
																	value="1"> 유 <input type="radio" name="marry"
																	value="2"> 무</td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="101" align="right"><strong>년차
																		:&nbsp;</strong></td>
																<td width="392"><input name="year" type="text"
																	size="10"></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="101" align="right"><strong>급여
																		지급유형 :&nbsp;</strong></td>
																<td width="392"><select name="paytype">
																		<option value="1">월급</option>
																		<option value="2">주급</option>
																</select></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="101" align="right"><strong>희망직무
																		:&nbsp;</strong></td>
																<td width="392"><select name="hopejob">
																		<option value="1">SI</option>
																		<option value="2">SM</option>
																</select></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="101" align="right"><strong>입사유형:&nbsp;</strong></td>
																<td width="392"><select name="jointype">
																		<option value="1">정규직</option>
																		<option value="2">계약직</option>
																</select></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="101" align="right"><strong>주소:&nbsp;</strong></td>
																<td width="392"><input name="address1" type="text"
																	size="10"> <input name="address2" type="text"
																	size="40"></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="101" align="right"><strong>연락처:&nbsp;</strong></td>
																<td width="392"><input name="phoneno1" type="text"
																	size="10"> - <input name="phoneno2" type="text"
																	size="10"> - <input name="phoneno3" type="text"
																	size="10"></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="101" align="right"><strong>이메일:&nbsp;</strong></td>
																<td width="392"><input name="email" type="text"
																	size="20"></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="101" align="right"><strong>기술등급:&nbsp;</strong></td>
																<td width="392"><input name="grade" type="text"
																	size="20"></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td bgcolor="#E4EBF1"><table width="500" border="0"
															cellspacing="1" cellpadding="1">
															<tr>
																<td width="101" align="right"><strong>주량:&nbsp;</strong></td>
																<td width="392"><input name="hoff" type="text"
																	size="20"></td>
															</tr>
														</table></td>
												</tr>
											</table></td>
									</tr>
								</table></td>
						</tr>
						<tr>
							<td height="3" align="center">&nbsp;</td>
						</tr>
						<tr>
							<td height="3" align="center"><table width="107" border="0"
									cellpadding="1" cellspacing="1">
									<tr>
										<td width="49"><img src="resources/image/bt_remove.gif"
											width="49" height="18" onclick="insert()"></td>
										<td width="51"><img src="resources/image/bt_cancel.gif"
											width="49" height="18" onclick="history.go(-1)"></td>
									</tr>
								</table></td>
						</tr>
						<tr>
							<td height="7" align="right">&nbsp;</td>
						</tr>
					</table></td>
			</tr>
		</table>
	</form>
</body>
</html>