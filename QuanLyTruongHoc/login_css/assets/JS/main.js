// Hàm chuyển động ảnh player
var indexPlayer = 0;
var imgElementsPlayer = document.getElementsByClassName('img__player');
function changeImagePlayer() {
    var imgs = ["./assets/img/messi.png", "./assets/img/CR7.png", "./assets/img/neymar.png", "./assets/img/haaland.png"];
    
    imgElementsPlayer[0].style.opacity = 0; // Ẩn ảnh hiện tại

    setTimeout(function() {
        imgElementsPlayer[0].src = imgs[indexPlayer];
        imgElementsPlayer[0].style.opacity = 1; // Hiển thị ảnh mới
        indexPlayer = (indexPlayer + 1) % imgs.length; // Đảm bảo vòng lặp qua các ảnh
    }, 1000); // Sau 1000 miliseconds, hiển thị ảnh mới
}
setInterval(changeImagePlayer, 3000);
changeImagePlayer();

// Hàm chuyển động image_background
var indexBackground = 0;
var imgElementsBackground = document.getElementsByClassName('img__background');
function changeImageBackground() {
    var imgs = ["./assets/img/bg1.png", "./assets/img/bg2.png", "./assets/img/bg3.png", "./assets/img/bg4.png"];

    imgElementsBackground[0].style.opacity = 1; 

    setTimeout(function() {
        imgElementsBackground[0].src = imgs[indexBackground];
        imgElementsBackground[0].style.opacity = 1;
        indexBackground = (indexBackground + 1) % imgs.length; 
    }, 1000); 
}
setInterval(changeImageBackground, 3000);
changeImageBackground();

// Hàm chuyển động img__logo
var indexLogo = 0;
var imgElementsLogo = document.getElementsByClassName('img__logo');
function changeImageLogo() {
    var imgs = ["./assets/img/Barca.png", "./assets/img/MU.png", "./assets/img/psg.png", "./assets/img/mc.png"];
    
    imgElementsLogo[0].style.opacity = 0; 

    setTimeout(function() {
        imgElementsLogo[0].src = imgs[indexLogo];
        imgElementsLogo[0].style.opacity = 0.6; 
        indexLogo = (indexLogo + 1) % imgs.length; 
    }, 1000); 
}
setInterval(changeImageLogo, 3000);
changeImageLogo();

