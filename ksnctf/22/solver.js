var canvas = document.createElement('canvas');
canvas.id = 'Canvas';
canvas.width = 10 * 31;
canvas.height = 10 * 31;

document.querySelector('body').appendChild(canvas);
var ctx = canvas.getContext('2d');

var cipher = document.querySelector('pre').textContent;

// 31 文字で 1 行
var list = cipher.match(/.{1,31}/g);

list.forEach(function(val, idx){
    val.split('').forEach(function(v,i){
        if(v.match(/[A-Z]/)){
            ctx.beginPath();
            ctx.fillRect(i * 10, idx * 10, 10, 10)
        }
    })
});
