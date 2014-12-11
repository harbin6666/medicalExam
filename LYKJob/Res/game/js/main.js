    //获得主界面
var mainDiv=document.getElementById("maindiv");
    //获得开始界面
var startdiv=document.getElementById("startdiv");
    //获得游戏中分数显示界面
var scorediv=document.getElementById("scorediv");
    //获得分数界面
var scorelabel=document.getElementById("label");
    //获得暂停界面
var suspenddiv=document.getElementById("suspenddiv");
    //获得游戏结束界面
//var enddiv=document.getElementById("enddiv");
    //获得游戏结束后分数统计界面
//var planscore=document.getElementById("planscore");
    //初始化分数
var scores=0;

var screenW = window.screen.width;
var screenH = window.screen.height;
var offet = screenW / 720;

/*
 创建飞机类
 */
function plan(hp,X,Y,sizeX,sizeY,score,dietime,sudu,boomimage,imagesrc){
    this.planX=X;
    this.planY=Y;
    this.imagenode=null;
    this.planhp=hp;
    this.planscore=score;
    this.plansizeX=sizeX;
    this.plansizeY=sizeY;
    this.planboomimage=boomimage;
    this.planisdie=false;
    this.plandietimes=0;
    this.plandietime=dietime;
    this.plansudu=sudu;
//行为
/*
移动行为
     */
    this.planmove=function(){
        if(scores<=50000){
            this.imagenode.style.top=this.imagenode.offsetTop+this.plansudu+2+"px";
        }
        else if(scores>50000&&scores<=100000){
            this.imagenode.style.top=this.imagenode.offsetTop+this.plansudu+3+"px";
        }
        else if(scores>100000&&scores<=150000){
            this.imagenode.style.top=this.imagenode.offsetTop+this.plansudu+4+"px";
        }
        else if(scores>150000&&scores<=200000){
            this.imagenode.style.top=this.imagenode.offsetTop+this.plansudu+5+"px";
        }
        else if(scores>200000&&scores<=300000){
            this.imagenode.style.top=this.imagenode.offsetTop+this.plansudu+6+"px";
        }
        else{
            this.imagenode.style.top=this.imagenode.offsetTop+this.plansudu+7+"px";
        }
    }
    this.init=function(){
        this.imagenode=document.createElement("img");
        this.imagenode.style.left=this.planX+"px";
        this.imagenode.style.top=this.planY+"px";
        this.imagenode.src=imagesrc;
        this.imagenode.style.width=this.plansizeX+"px";
        this.imagenode.style.height=this.plansizeY+"px";
        mainDiv.appendChild(this.imagenode);
    }
    this.init();
}

/*
创建子弹类
 */
function bullet(X,Y,sizeX,sizeY,imagesrc){
    this.bulletX=X;
    this.bulletY=Y;
    this.bulletimage=null;
    this.bulletattach=1;
    this.bulletsizeX=sizeX;
    this.bulletsizeY=sizeY;
//行为
/*
 移动行为
 */
    this.bulletmove=function(){
        this.bulletimage.style.top=this.bulletimage.offsetTop-20+"px";
    }
    this.init=function(){
        this.bulletimage=document.createElement("img");
        this.bulletimage.style.left= this.bulletX+"px";
        this.bulletimage.style.top= this.bulletY+"px";
        this.bulletimage.src=imagesrc;
        this.bulletimage.style.width=this.bulletsizeX+"px";
        this.bulletimage.style.height=this.bulletsizeY+"px";
        mainDiv.appendChild(this.bulletimage);
    }
    this.init();
}

/*
 创建单行子弹类
 */
function oddbullet(X,Y){
	var sizeX = parseInt(6 * 2 * offet);
	var sizeY = parseInt(14 * 2 * offet);
    bullet.call(this,X,Y,sizeX,sizeY,"images/bullet1.png");
}

/*
创建敌机类
 */
function enemy(hp,a,b,sizeX,sizeY,score,dietime,sudu,boomimage,imagesrc){
    plan.call(this,hp,random(a,b),-100,sizeX,sizeY,score,dietime,sudu,boomimage,imagesrc);
}
//产生min到max之间的随机数
function random(min,max){
    return Math.floor(min+Math.random()*(max-min));
}

/*
创建本方飞机类
 */
function ourplan(){
    var imagesrc="images/mp.gif";
    var sizeX = parseInt(66 * 2 * offet);
    var sizeY = parseInt(80 * 2 * offet);
    
    var X = parseInt(screenW / 2 - sizeX / 2);
    var Y = parseInt(screenH - sizeY * 2);
    plan.call(this,1,X,Y,sizeX,sizeY,0,660,0,"images/mpbz.gif",imagesrc);
    this.imagenode.setAttribute('id','ourplan');
}

/*
 创建本方飞机
 */
var selfplan=new ourplan();
//移动事件
var ourPlan=document.getElementById('ourplan');
var yidong=function(event){
	/*
    var oevent=window.event||arguments[0];
    var chufa=oevent.srcElement||oevent.target;
    var selfplanX=oevent.clientX-500;
    var selfplanY=oevent.clientY;
    ourPlan.style.left=selfplanX-selfplan.plansizeX/2+"px";
    ourPlan.style.top=selfplanY-selfplan.plansizeY/2+"px";
    */
	if (event.targetTouches.length == 1) {//这个元素的位置内只有一个手指的话
		event.preventDefault();// 阻止浏览器默认事件
		var touch = event.targetTouches[0];
		var selfplanX=touch.pageX;
	    var selfplanY=touch.pageY;
	    ourPlan.style.left=selfplanX-selfplan.plansizeX/2+"px";
	    ourPlan.style.top=selfplanY-selfplan.plansizeY/2+"px";
	}
}
/*
暂停事件
 */
var number=0;
var zanting=function(){
    if(number==0){
        suspenddiv.style.display="block";
        var w = parseInt($('#suspenddiv').css("width"));
        var h = parseInt($('#suspenddiv').css("height"));
        suspenddiv.style.left = parseInt(screenW / 2 - w / 2) + "px";
        suspenddiv.style.top = parseInt(screenH / 2 - h / 2) + "px";
        if(document.removeEventListener){
            mainDiv.removeEventListener("touchmove",yidong,true);
            bodyobj.removeEventListener("touchmove",bianjie,true);
        }
        else if(document.detachEvent){
            mainDiv.detachEvent("ontouchmove",yidong);
            bodyobj.detachEvent("ontouchmove",bianjie);
        }
        clearInterval(set);
        number=1;
    }
    else{
        suspenddiv.style.display="none";
        if(document.addEventListener){
            mainDiv.addEventListener("touchmove",yidong,true);
            bodyobj.addEventListener("touchmove",bianjie,true);
        }
        else if(document.attachEvent){
            mainDiv.attachEvent("ontouchmove",yidong);
            bodyobj.attachEvent("ontouchmove",bianjie);
        }
        set=setInterval(start,20);
        number=0;
    }
}
//判断本方飞机是否移出边界,如果移出边界,则取消mousemove事件,反之加上mousemove事件
var bianjie=function(event){
    var oevent=window.event||arguments[0];
    var bodyobjX=oevent.clientX;
    var bodyobjY=oevent.clientY;
    if(bodyobjX< parseInt(66 *2* offet) ||bodyobjX> parseInt(screenW-  66 * 2 * offet) ||bodyobjY< parseInt(80 * 2 * offet) || bodyobjY> parseInt(screenH - 80 * 2 * offet)){
        if(document.removeEventListener){
            mainDiv.removeEventListener("touchmove",yidong,true);
        }
        else if(document.detachEvent){
            mainDiv.detachEvent("ontouchmove",yidong);
        }
    }
    else{
        if(document.addEventListener){
            mainDiv.addEventListener("touchmove",yidong,true);
        }
        else if(document.attachEvent){
            mainDiv.attachEvent("ontouchmove",yidong);
        }
    }
	
	if (event.targetTouches.length == 1) {//这个元素的位置内只有一个手指的话
		event.preventDefault();// 阻止浏览器默认事件
		var touch = event.targetTouches[0];
		var bodyobjX=touch.pageX;
	    var bodyobjY=touch.pageY;
	    if(bodyobjX<parseInt(66 * offet)||bodyobjX>parseInt(screenW-  66 * offet)||bodyobjY<parseInt(80 * offet)||bodyobjY>parseInt(screenH - 80 * offet)){
	        if(document.removeEventListener){
	            mainDiv.removeEventListener("touchmove",yidong,true);
	        }
	        else if(document.detachEvent){
	            mainDiv.detachEvent("ontouchmove",yidong);
	        }
	    }
	    else{
	        if(document.addEventListener){
	            mainDiv.addEventListener("touchmove",yidong,true);
	        }
	        else if(document.attachEvent){
	            mainDiv.attachEvent("ontouchmove",yidong);
	        }
	    }
	}
}
//暂停界面重新开始事件
function chongxinkaishi(){
    location.reload(true);
    startdiv.style.display="none";
    maindiv.style.display="block";
}
var bodyobj=document.getElementsByTagName("body")[0];
if(document.addEventListener){
    //为本方飞机添加移动和暂停
    mainDiv.addEventListener("touchmove",yidong,true);
    //为本方飞机添加暂停事件
    selfplan.imagenode.addEventListener("click",zanting,true);
    //为body添加判断本方飞机移出边界事件
    bodyobj.addEventListener("touchmove",bianjie,true);
    //为暂停界面的继续按钮添加暂停事件
    suspenddiv.getElementsByTagName("button")[0].addEventListener("click",zanting,true);
    suspenddiv.getElementsByTagName("button")[1].addEventListener("click",chongxinkaishi,true);
    //为暂停界面的返回主页按钮添加事件
    suspenddiv.getElementsByTagName("button")[2].addEventListener("click",jixu,true);
}
else if(document.attachEvent){
    //为本方飞机添加移动
    mainDiv.attachEvent("ontouchmove",yidong);
    //为本方飞机添加暂停事件
    selfplan.imagenode.attachEvent("onclick",zanting);
    //为body添加判断本方飞机移出边界事件
    bodyobj.attachEvent("ontouchmove",bianjie);
    //为暂停界面的继续按钮添加暂停事件
    suspenddiv.getElementsByTagName("button")[0].attachEvent("onclick",zanting);
//    suspenddiv.getElementsByTagName("button")[1].attachEvent("click",chongxinkaishi,true);
    //为暂停界面的返回主页按钮添加事件
    suspenddiv.getElementsByTagName("button")[2].attachEvent("click",jixu,true);
}
//初始化隐藏本方飞机
selfplan.imagenode.style.display="none";

/*
敌机对象数组
 */
var enemys=[];

/*
子弹对象数组
 */
var bullets=[];
var mark=0;
var mark1=0;
var backgroundPositionY=0;
/*
开始函数
 */
function start(){
    mainDiv.style.backgroundPositionY=backgroundPositionY+"px";
    backgroundPositionY+=0.5;
    if(backgroundPositionY==screenH){
        backgroundPositionY=0;
    }
    mark++;
    /*
    创建敌方飞机
     */

    if(mark==20){
        mark1++;
        //中飞机
        if(mark1%5==0){
            enemys.push(new enemy(6,parseInt(25 * 2 * offet),parseInt(274 * 2 * offet),parseInt(46 * 2 * offet),parseInt(60 * 2 * offet),5000,360,random(1,3),"images/zpbz.gif","images/enemy3_fly_1.png"));
        }
        //大飞机
        if(mark1==20){
            enemys.push(new enemy(12,parseInt(57 * 2 * offet),parseInt(210 * 2 * offet),parseInt(110 * 2 * offet),parseInt(164 * 2 * offet),30000,540,1,"images/dpbz.gif","images/enemy2_fly_1.png"));
            mark1=0;
        }
        //小飞机
        else{
            enemys.push(new enemy(1,parseInt(19 * 2 * offet),parseInt(286 * 2 * offet),parseInt(34 * 2 * offet),parseInt(24 * 2 * offet),1000,360,random(1,4),"images/spbz.gif","images/enemy1_fly_1.png"));
        }
        mark=0;
    }

/*
移动敌方飞机
 */
    var enemyslen=enemys.length;
    for(var i=0;i<enemyslen;i++){
        if(enemys[i].planisdie!=true){
            enemys[i].planmove();
        }
/*
 如果敌机超出边界,删除敌机
 */
        if(enemys[i].imagenode.offsetTop>screenH){
            mainDiv.removeChild(enemys[i].imagenode);
            enemys.splice(i,1);
            enemyslen--;
        }
        //当敌机死亡标记为true时，经过一段时间后清除敌机
        if(enemys[i].planisdie==true){
            enemys[i].plandietimes+=20;
            if(enemys[i].plandietimes==enemys[i].plandietime){
                mainDiv.removeChild(enemys[i].imagenode);
                enemys.splice(i,1);
                enemyslen--;
            }
        }
    }

/*
创建子弹
*/
    if(mark%5==0){
            bullets.push(new oddbullet(parseInt(parseInt(selfplan.imagenode.style.left) + (parseInt(selfplan.imagenode.style.width) / 2) - parseInt(6 * offet)),parseInt(selfplan.imagenode.style.top) - 15));
    }

/*
移动子弹
*/
    var bulletslen=bullets.length;
    for(var i=0;i<bulletslen;i++){
        bullets[i].bulletmove();
/*
如果子弹超出边界,删除子弹
*/
        if(bullets[i].bulletimage.offsetTop<0){
            mainDiv.removeChild(bullets[i].bulletimage);
            bullets.splice(i,1);
            bulletslen--;
        }
    }

/*
碰撞判断
*/
    for(var k=0;k<bulletslen;k++){
        for(var j=0;j<enemyslen;j++){
            //判断碰撞本方飞机
            if(enemys[j].planisdie==false){
                if(enemys[j].imagenode.offsetLeft+enemys[j].plansizeX>=selfplan.imagenode.offsetLeft&&enemys[j].imagenode.offsetLeft<=selfplan.imagenode.offsetLeft+selfplan.plansizeX){
                  if(enemys[j].imagenode.offsetTop+enemys[j].plansizeY>=selfplan.imagenode.offsetTop+40&&enemys[j].imagenode.offsetTop<=selfplan.imagenode.offsetTop-20+selfplan.plansizeY){
                      //碰撞本方飞机，游戏结束，统计分数
                      selfplan.imagenode.src="images/mpbz.gif";
                      //enddiv.style.display="block";
                      //planscore.innerHTML=scores;
                      if(scores == 0){
                    	  scores = 1;
                      }
                     
					  window.location.href="user!getResult?score="+scores;
                      
                      if(document.removeEventListener){
                          mainDiv.removeEventListener("touchmove",yidong,true);
                          bodyobj.removeEventListener("touchmove",bianjie,true);
                      }
                      else if(document.detachEvent){
                          mainDiv.detachEvent("ontouchmove",yidong);
                          bodyobj.removeEventListener("touchmove",bianjie,true);
                      }
                      clearInterval(set);
                  }
                }
                //判断子弹与敌机碰撞
                if((bullets[k].bulletimage.offsetLeft+bullets[k].bulletsizeX>enemys[j].imagenode.offsetLeft)&&(bullets[k].bulletimage.offsetLeft<enemys[j].imagenode.offsetLeft+enemys[j].plansizeX)){
                    if(bullets[k].bulletimage.offsetTop<=enemys[j].imagenode.offsetTop+enemys[j].plansizeY&&bullets[k].bulletimage.offsetTop+bullets[k].bulletsizeY>=enemys[j].imagenode.offsetTop){
                        //敌机血量减子弹攻击力
                        enemys[j].planhp=enemys[j].planhp-bullets[k].bulletattach;
                        //敌机血量为0，敌机图片换为爆炸图片，死亡标记为true，计分
                        if(enemys[j].planhp==0){
                            scores=scores+enemys[j].planscore;
                            scorelabel.innerHTML=scores;
                            enemys[j].imagenode.src=enemys[j].planboomimage;
                            enemys[j].planisdie=true;
                        }
                        //删除子弹
                        mainDiv.removeChild(bullets[k].bulletimage);
                            bullets.splice(k,1);
                            bulletslen--;
                            break;
                    }
                }
            }
        }
    }
}
/*
开始游戏按钮点击事件
 */
var set;
function begin(){
	startdiv.style.display="none";
	mainDiv.style.display="block";
	selfplan.imagenode.style.display="block";
	scorediv.style.display="block";
	/*
	 调用开始函数
	 */
	set=setInterval(start,20);
}

//游戏结束后点击继续按钮事件
function jixu(){
    location.reload(true);
}

/*
    完成界面的初始化
    敌方小飞机一个
    我方飞机一个
 */
