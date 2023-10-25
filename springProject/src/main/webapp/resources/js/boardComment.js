
document.getElementById('cmtPostBtn').addEventListener('click',()=>{
    const cmtText = document.getElementById('cmtText').value;
    const cmtWriter = document.getElementById('cmtWriter').innerText;
    if(cmtText==""||cmtText==null){
        alert("댓글 내용을 입력해 주세요.");
        document.getElementById('cmtText').focus();
        return false;
    }else{
        let cmtData={
            bno : bnoVal,
            writer : cmtWriter,
            content : cmtText
        };
        console.log(cmtData);
        postCommentToServer(cmtData).then(result=>{
            if(result == 1){
                alert("댓글등록 성공!");
                console.log(result);
                document.getElementById('cmtText').value = '';

                getCommentList(bnoVal);
               // location.reload(); //새로고침 (적용시 댓글만 달아도 게시판 조회수 증가됨)
            }
        })
    }
})



async function postCommentToServer(cmtData){
    try {
        const url = "/comment/post";
        const config={
            method:"post",
            headers:{
                'content-type':'application/json; charset-utf-8'
            },
            body: JSON.stringify(cmtData)
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (err) {
        console.log(err);
    }
}



async function spreadCommentListFromServer(bno, page){
    console.log(bno);
    try {
        const resp = await fetch('/comment/'+bno+'/'+page);
        const result = await resp.json();
        return result;
    } catch (err) {
        console.log(err);
    }
}



function getCommentList(bno, page=1){ //무조건 처음 뿌릴때는 첫 페이지 값을 뿌려야함.
    spreadCommentListFromServer(bno, page).then(result=>{
        console.log(result); //ph 객체 pgvo, totalCount, cmtList
        const ul = document.getElementById('cmtListArea');
        const divCmt = document.getElementById('cmtCount');
        
        if(result.cmtList.length > 0){
            //다시 댓글을 뿌릴 때 기존 값 삭제, 1page일 경우만
            if(page==1){
                ul.innerHTML = "";
            }

            console.log(result.cmtList.length);
            let cmtQty = `<div id="cmtCount">Comment(<span class="cmtQty">${result.cmtList.length}</span>)</div>`;
            divCmt.innerHTML = cmtQty;

            for(let cvo of result.cmtList){
                let str=`<li class="list-group-item" data-cno="${cvo.cno}">`;
                str+=`<div class="mb-3">`;
                str+=`<span class="fw-bold">${cvo.writer}  </span>`;
                str+=`<span class="badge text-bg-secondary">${cvo.modAt}</span>`;
                str+=`<div>${cvo.content}</div></div>`;
                str+=`<button type="button" class="btn btn-outline-primary mod" data-bs-toggle="modal" data-bs-target="#myModal">%</button>`;
                str+=`<button type="button" class="btn btn-outline-secondary cmtDelBtn del">X</button>`;
                str+=`</li>`;
                ul.innerHTML += str;
            }
            //댓글 페이징 코드
            let moreBtn = document.getElementById('moreBtn');
            //db에서 pgvo + list 같이 가져와야 값을 줄 수 있음.
            if(result.pgvo.pageNo < result.endPage || result.next){
                moreBtn.style.visibility = 'visible';
                moreBtn.dataset.page = page + 1;
            }else{
                moreBtn.style.visibility = 'hidden'; //버튼 숨김
            }

        }else{
            let str = `<li class="noneCmt">당신의 의견을 남겨주세요.</li>`;
            ul.innerHTML = str;
        }
    })
}



async function removeCommentToServer(cno){
    try {
        const url='/comment/'+cno;
        const config={
            method:'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (err) {
        console.log(err);
    }
}



async function editCommentToServer(cmtDataMod){
    try {
        const url = '/comment/'+cmtDataMod.cno;
        const config = {
            method: 'put',
            headers:{
                'Content-Type' : 'application/json; charset=UTF-8'
            },
            body : JSON.stringify(cmtDataMod)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (err) {
        console.log(err);
    }
}




document.addEventListener('click',(e)=>{
    //console.log(e.target);
    if(e.target.classList.contains('cmtDelBtn')){
		let li = e.target.closest('li');
        let cnoVal = li.dataset.cno; 
        console.log(cnoVal);
        removeCommentToServer(cnoVal).then(result=>{
            if(result==1){
                alert('댓글을 삭제 하였습니다.');
            }
            getCommentList(bnoVal);
        })
    }else if(e.target.classList.contains('mod')){
        let li = e.target.closest('li');
        //nextSibling(): 같은 부모의 다음 형제 객체를 반환
        let cmtText = li.querySelector('.text-bg-secondary').nextSibling;
        console.log(cmtText.innerText);

        //기존 내용 모달창에 반영 (수정하기 편하게..)
        document.getElementById('cmtTextMod').value = cmtText.innerText;
        //cmtModBtn에 data-cno 달기
        document.getElementById('cmtModBtn').setAttribute('data-cno', li.dataset.cno);
    }else if(e.target.id == 'cmtModBtn'){
        let cmtDataMod={
            cno : e.target.dataset.cno,
            content : document.getElementById('cmtTextMod').value
        }
        console.log(cmtDataMod);
        editCommentToServer(cmtDataMod).then(result=>{
            if(parseInt(result)){
                //모달창 닫기
                document.querySelector('.btn-close').click();
            }
            getCommentList(bnoVal);
        })
    }else if(e.target.id == 'moreBtn'){
        getCommentList(bnoVal, parseInt(e.target.dataset.page));
    }
})



