<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<link href="resources/css/style.css" rel="stylesheet" type="text/css">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>




$(document).ready(function(){
	reload();
	
	$("#allCheck").click(function() {
		if($("#allCheck").is(":checked")) $("input[name=indexnos]").prop("checked", true);
		else $("input[name=indexnos]").prop("checked", false);
	});

	$("#allCheck").click(function() {
		var total = $("input[name=indexnos]").length;
		var checked = $("input[name=indexnos]:checked").length;

		if(total != checked) $("#allCheck").prop("checked", false);
		else $("#allCheck").prop("checked", true); 
	});
});//document ready
//페이징 ,리스트




function modify(){
	if ($(".indexnos:checked").length == 1){
	$("input[name=indexno]").val($("input:checkbox[name=indexnos]:checked").val());
	window.parent.location.href = "/modify?indexno="+$("input[name=indexno]").val();
	}else{
		alert("하나만 체크하시오")
	}
}

function deletes(){
	if(confirm("삭제 하시겠습니까?")){
			var checkArray =[];	
			$('input[name="indexnos"]:checked').each(function(i){
				checkArray.push($(this).val());
			});
			var params={
					"check" : checkArray
			};
		    // ajax 통신
		$.ajax({
		        type : "POST",            // HTTP method type(GET, POST) 형식이다.
		        url : "/deleteAjax",      // 컨트롤러에서 대기중인 URL 주소이다.
		        data : params, 
		        dataType : "json",// Json 형식의 데이터이다.
		        success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
		        	alert("삭제되었습니다")
		        	reload();
		        	$("#allCheck").prop("checked", false);
		        },
		        error : function(request, status, error){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
		        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		        }
		   });
	}
}



function reload(){
	
    var params = $("#actionForm").serialize();
    // ajax 통신
    $.ajax({
        type : "POST",            // HTTP method type(GET, POST) 형식이다.
        url : "/listAjax",      // 컨트롤러에서 대기중인 URL 주소이다.
        data : params, 
        dataType : "json",// Json 형식의 데이터이다.
        success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
			list(res.list);
        	paging(res.pb);
        },
        error : function(request, status, error){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}//reload


//페이징 
function pagingC(e){
	$("input[name=page]").val($(e).attr("page"));
	reload();
};//paging wrap end



function list(list){
    // json 형식으로 데이터 set
    var html =""; 
    list.forEach(function(i){                                                      
	html+=' <tr>                                                                                            ';
	html+='  <td height="20" align="center"><input type="checkbox" name="indexnos" value='+i.INDEXNO+' class="indexnos"></td>  ';
	html+='  <td align="center">'+i.KORNAME+'</td>                                                                 ';
	html+='  <td align="center">'+i.RESNO+'</td>                                                                 ';
	html+='  <td align="center">'+i.GENDER+'</td>                                                                 ';
	html+='  <td align="center">'+i.GRADE+'</td>                                                                 ';
	html+='  <td align="center">'+i.JOINTYPE+'</td>                                                                 ';
	html+='  <td align="center">'+i.HOPEJOB+'</td>                                                                 ';
	html+='<td align="center">';
	if(i.EXCELLOCAL != null){
		html+='<a href="http://localhost:8080/resources/upload/'+i.EXCELLOCAL+'")download><img src="resources/image/excel.png"  width="20" height="20" border="0" align="absmiddle"></a>';
	}
	if(i.WORDLOCAL != null){
		html+='<a href="http://localhost:8080/resources/upload/'+i.WORDLOCAL+'" download><img src="resources/image/word.png"  width="10" height="10" border="0" align="absmiddle"></a>';
	}
	html+='</td>';

	html+='</tr>    ';
    html+='	<tr>                                                                                ';
   	html+='	 <td colspan="7" background="resources/image/line_bg.gif"></td>                     ';
 	html+=' </tr>                                                                               ';
    });
	$("#list").html(html);
};

function paging(pb){
	var html ="";
	                                                                                                                      
   html+=' <td height="35" colspan="7" align="center" style="padding-bottom:3"><a href="#">                                   ';
   html+=' <img onclick="pagingC(this)" src="resources/image/prev.gif" page="1" width="22" height="15" border="0" align="absmiddle"></a>&nbsp;     ';   
   if(pb.startPcount == 1){
   		html+=' <a href="#" page="1" onclick="pagingC(this)"s><img src="resources/image/pre.gif" width="42" height="15" border="0" align="absmiddle"></a>&nbsp;                  ';
   }else{
		html+=' <a href="#" page='+(pb.startPcount - 5)+' onclick="pagingC(this)"><img src="resources/image/pre.gif" width="42" height="15" border="0" align="absmiddle"></a>&nbsp;                  ';   
   }
   
   for(var i = pb.startPcount;  i <= pb.endPcount; i++){
	if(i != pb.endPcount){
		if(i == $("input[name=page]").val())
			html+=' <a page='+i+' onclick="pagingC(this)" style="color:red">'+i+'</a> |';
		else{
			html+=' <a page='+i+' onclick="pagingC(this)">'+i+'</a> |';
		}
	}else{
		if(i == $("input[name=page]").val()){	
			html+=' <a page='+i+' onclick="pagingC(this)" style="color:red">'+i+'</a>&nbsp;';
		}else {
			html+=' <a page='+i+' onclick="pagingC(this)">'+i+'</a>&nbsp;';
		}
	}
   }
   
   if(pb.maxPcount <= pb.endPcount){
   html+=' <a href="#" page='+pb.maxPcount+' onclick="pagingC(this)">  <img src="resources/image/next.gif" width="42" height="15" border="0" align="absmiddle"></a>&nbsp;                 ';
   }else {
	html+=' <a href="#" page='+(pb.endPcount + 1)+' onclick="pagingC(this)">  <img src="resources/image/next.gif" width="42" height="15" border="0" align="absmiddle"></a>&nbsp;                 ';
   }
   
   html+=' <a href="#" onclick="pagingC(this)" page='+pb.maxPcount+'><img src="resources/image/next_.gif" width="22" height="15" border="0" align="absmiddle"></a></td>     ';
   
   
	$("#paging").html(html);
};
	
function search(){
	$('input[name=page]').val('1');
	reload();
}



</script>
</head>
<body topmargin="0" leftmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td height="25"><img src="resources/image/icon.gif" width="9" height="9" align="absmiddle"> 
      <strong >사원조회</strong></td>
  </tr>
  <tr> 
    <td><table width="640" border="0" cellspacing="0" cellpadding="0">
         <form action="#" method="get" id="actionForm"> 
         <tr height="30"  align="right">
        	 <td>
            <span>성별 : </span>
            <select name="genderSearch" class="INPUT">
              <option value='all'>전체</option>
              <option value='1'>남자</option>
              <option value='2'>여자</option>

            </select>
             <span>기술등급 : </span>
                <select name="gradeSearch" class="INPUT">
              <option value='all'>전체</option>
              <option value='초급'>초급</option>
              <option value='중급'>중급</option>
              <option value='고급'>고급</option>

            </select>
             <span>상태: </span>
               <select name="jointypeSearch" class="INPUT">
              <option value='all'>전체</option>
              <option value='1'>정규직</option>
              <option value='2'>계약직</option>
            </select>
             <span>근무: </span>
               <select name="hopejobSearch" class="INPUT">
              <option value='all'>전체</option>
              <option value='1'>SI</option>
              <option value='2'>SM</option>
            </select>    
            </td>
            

         </tr>
         
        <tr> 
          <td height="30" align="right">   
          <select name="searchType" class="INPUT">
          
          
              <option value="all">::::: 전체 :::::</option>
              <option value="korname">::::: 이름 :::::</option>
              <option value="gender">::::: 성별 :::::</option>
              <option value="grade">::::: 기술등급 :::::</option>
            </select> <input name="searchTxt" type="text" class="INPUT"> <a href="#" ><img src="resources/image/search.gif" onclick="search()" width="49" height="18" border="0" align="absmiddle"></a></td>
          <input type="hidden" name="page" value="${page}">
     	  <input type="hidden" name="indexno">   
     
        </tr>
	</form>
        <tr> 
          <td><table width="640" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="3" background="resources/image/bar_bg1.gif"></td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="26" align="right" bgcolor="F8F8F8" style="padding-right:10"><img src="resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#" onclick="modify()">수정</a> <img src="resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#" onclick="deletes()">삭제</a> <img src="resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">인사기록카드</a> <img src="resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">경력정보</a> <img src="resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">근무정보</a> </td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="1" align="right" bgcolor="B1B1B1"></td>
              </tr>
              <tr> 
                <td>
				<!-------------------------  리스트 ------------------------------>
				<table width="640" border="0" cellspacing="0" cellpadding="0">
					<thead>
                    <tr> 
                      <th width="35" height="20" align="center"><input type="checkbox" id="allCheck" name="checkbox" value="checkbox"></th>
                      <th width="85" align="center">이름</th>
                      <th width="153" align="center">주민번호</th>
                      <th width="91" align="center">성별</th>
                      <th width="91" align="center">기술등급</th>
                      <th width="91" align="center">상태</th>
                      <th width="94" align="center">근무</th>
                      <th width="91" align="center">문서파일</th>
                    </tr>
                    <tr> 
                      <td colspan="7" background="resources/image/line_bg.gif"></td>
                    </tr>
                    </thead>
                    <tbody id="list">
                    <tr> 
                      <td height="20" align="center"><input type="checkbox" name="checkbox2" value="checkbox"></td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="7" background="resources/image/line_bg.gif"></td>
                    </tr>
                    <tr> 
                      <td height="20" align="center"><input type="checkbox" name="checkbox3" value="checkbox"></td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="7" background="resources/image/line_bg.gif"></td>
                    </tr>
                    <tr> 
                      <td height="20" align="center"><input type="checkbox" name="checkbox4" value="checkbox"></td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="7" background="resources/image/line_bg.gif"></td>
                    </tr>
                    <tr> 
                      <td height="20" align="center"><input type="checkbox" name="checkbox5" value="checkbox"></td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="7" background="resources/image/line_bg.gif"></td>
                    </tr>
                    <tr> 
                      <td height="20" align="center"><input type="checkbox" name="checkbox6" value="checkbox"></td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="7" background="resources/image/line_bg.gif"></td>
                    </tr>
                    <tr> 
                      <td height="20" align="center"><input type="checkbox" name="checkbox7" value="checkbox"></td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="7" background="resources/image/line_bg.gif"></td>
                    </tr>
                    <tr> 
                      <td height="20" align="center"><input type="checkbox" name="checkbox8" value="checkbox"></td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="7" background="resources/image/line_bg.gif"></td>
                    </tr>
                    <tr> 
                      <td height="20" align="center"><input type="checkbox" name="checkbox9" value="checkbox"></td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="7" background="resources/image/line_bg.gif"></td>
                    </tr>
                    <tr> 
                      <td height="20" align="center"><input type="checkbox" name="checkbox10" value="checkbox"></td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                      <td align="center">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="7" background="resources/image/line_bg.gif"></td>
                    </tr>

                     </tbody>
                     
                    <tr id="paging"> 
                      <td height="35" colspan="7" align="center" style="padding-bottom:3"><a href="#"><img src="resources/image/prev.gif" width="22" height="15" border="0" align="absmiddle"></a>&nbsp;<a href="#"><img src="resources/image/pre.gif" width="42" height="15" border="0" align="absmiddle"></a>&nbsp; 
                        1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 &nbsp;<a href="#"><img src="resources/image/next.gif" width="42" height="15" border="0" align="absmiddle"></a>&nbsp;<a href="#"><img src="resources/image/next_.gif" width="22" height="15" border="0" align="absmiddle"></a></td>
                    </tr>

                  </table>
 				<!-------------------------  리스트 ------------------------------>
				  </td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="1" align="right" bgcolor="B1B1B1"></td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="26" align="right" bgcolor="F8F8F8" style="padding-right:10"><img src="resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#" onclick="modify()">수정</a> <img src="resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#" onclick="deletes()">삭제</a> <img src="resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">인사기록카드</a> <img src="resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">경력정보</a> <img src="resources/image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">근무정보</a> </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="3" background="resources/image/bar_bg1.gif"></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>