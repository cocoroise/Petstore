//需要首先通过Jq来解决内容部分奇偶行的背景色不同
$(document).ready(function(){
    trEdit();//td的点击事件封装成一个函数
});

/*下面兩段开始添加删除行**/
$(document).ready(function() {
    $("#addBtn").bind("click", function(){
        $(`<tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td><input name="productImgUpload" 
                    type="file" 
                    id="productImgUpload"
                    /></td>
                    <td class="del-col">
                <div class="ui buttons center aligned segment">
                <button id="delBtn"
        class="ui positive button"
            onclick="updatePet(${"${allPet[i].id}"})">save</button>
                <div class="or"></div>
                <button class= "delBtn ui negative button" onclick="deletePet(${"${allPet[i].id}"})">delete</button>
                </div>
                </td>
                 </tr>`).insertBefore(".append-row");
        trEdit();
        delTr();
    });
    delTr();
});

//删除
function delTr(){
    $(".delBtn").click(function(){
        $(this).parent().parent().remove();
    });
}


//我们需要找到所有的单元格
function trEdit(){
    let numTd = $("tbody td").not(".del-col");
    //给这些单元格注册鼠标点击的事件
    numTd.click(function() {
        //找到当前鼠标点击的td,this对应的就是响应了click的那个td
        let tdObj = $(this);
        if (tdObj.children("input").length > 0) {
            //当前td中input，不执行click处理
            return false;
        }
        let text = tdObj.html();
        //清空td中的内容
        tdObj.html("");
        //创建一个文本框
        //去掉文本框的边框
        //需要将当前td中的内容放到文本框中
        //将文本框插入到td中
        let inputObj = $("<input type='text'>").css({"padding":"0px","margin":"0px","height":"40px","font-size":"14px"})
            .width(tdObj.width())
            .height(tdObj.height())
            .css("background-color",tdObj.css("background-color"))
            .val(text).appendTo(tdObj);
        //是文本框插入之后就被选中
        inputObj.trigger("focus").trigger("select");
        inputObj.click(function() {
            return false;
        });

        inputObj.blur(function () {
            let inputtext = $(this).val();
            //将td的内容修改成文本框中的内容
            tdObj.html(inputtext);
        })

        //处理文本框上回车和esc按键的操作
        inputObj.keyup(function(event){
            //获取当前按下键盘的键值
            let keycode = event.which;
            //处理回车的情况
            if (keycode === 13) {
                //获取当当前文本框中的内容
                let inputtext = $(this).val();
                //将td的内容修改成文本框中的内容
                tdObj.html(inputtext);
            }
            //处理esc的情况
            if (keycode === 27) {
                //将td中的内容还原成text
                tdObj.html(text);
            }
        });
    });
}


