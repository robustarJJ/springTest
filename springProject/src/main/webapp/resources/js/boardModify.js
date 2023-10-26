async function removeFileToServer(uuid){
    try{
        const url='/board/file/'+uuid;
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


document.addEventListener('click',(e)=>{
    console.log(e.target);
    if(e.target.classList.contains('file-x')){
        let uuid = e.target.dataset.uuid;
        console.log(uuid);
        e.target.closest('li').remove(); //li삭제
       // location.reload(); //새로고침

       document.getElementById('regBtn').addEventListener('click',()=>{
        console.log('>> uuid >>> '+uuid);
        removeFileToServer(uuid).then(result=>{
            if(result==1){
                console.log("파일삭제 성공");
            }else{
                console.log("파일삭제 실패");
                }

            })
        });
       
    } 
})
        















// async function removeFileToServer(uuid){
//     try{
//         const url='/board/file/'+uuid;
//         const config={
//             method:'delete'
//         };
//         const resp = await fetch(url, config);
//         const result = await resp.text();
//         return result;
//     } catch (err) {
//         console.log(err);
//     }
// }


// document.addEventListener('click',(e)=>{
//     console.log(e.target);
//     if(e.target.classList.contains('file-x')){
//         let uuid = e.target.dataset.uuid;
//         console.log(uuid);
//         removeFileToServer(uuid).then(result=>{
//             if(result==1){
//                 alert('파일삭제 성공~!!');
//                 console.log("파일삭제");
//                 e.target.closest('li').remove(); //li삭제
//                 location.reload(); //새로고침
//             }else{
//                 alert('파일삭제 실패!');
//             }
//         })
//     }
// })