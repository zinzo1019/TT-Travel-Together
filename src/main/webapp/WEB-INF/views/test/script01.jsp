<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>

<style>
    .active {
        background: yellow;
    }
</style>

<body>
<h1 id="title">제목 미정</h1>

<div class="fruits-div">
    <div class="fruit">딸기</div>
    <div class="fruit">바나나</div>
    <div class="fruit">수박</div>
</div>
<br><br>

<form>
    <label>이메일<input type="email"/></label><br>
    <label>비밀번호<input type="password"/></label>
</form>
</body>
</html>

<script>
    /** 제목 바꾸기 */
    let select_title = document.querySelector('h1#title');
    select_title.textContent = '제목';
    console.log(select_title);

    /** 과일에 테두리 추가하기 */
    let fruits = document.querySelectorAll('div.fruit');
    console.log(fruits);
    fruits.forEach((fruit) => {
        fruit.style.border = '1px solid black';
        fruit.style.padding = '25px';
        fruit.style.width = '50px';
    })

    /** 바나나에 클래스 추가하기 */
    let banana = document.querySelectorAll('div.fruit')[1];
    banana.classList.add('active');

    /** 바나나 클래스의 형제/부모 요소 선택하기 */
    banana.nextElementSibling.style.color = 'red';
    banana.previousElementSibling.style.color = 'green';
    banana.parentElement.style.background = 'skyblue';

    /** 과일들 배열에 담기 */
    let div_fruits = document.getElementsByClassName('fruit');

    // 방법 1
    // let fruits_list = []
    // div_fruits.forEach((fruit) => {
    //     fruits_list.push(fruit.textContent);
    // })

    // 방법 2. 전개 연산자
    let fruits_list = [...div_fruits].map(fruit => fruit.textContent);
    console.log('과일 => ' + fruits_list);

    /** 이메일/비밀번호 초기화 */
    let email = document.querySelector('input[type="email"]');
    let password = document.querySelector('input[type="password"]');
    email.value = 'user1@naver.com';
    password.value = '1234';

    /** 비동기 */
    new Promise(function(resolve, reject) {
        setTimeout(() => resolve(1), 1000);
    }).then(function (result) {
        console.log(result);
        return result + 1;
    }).then(function (result) {
        console.log(result);
        return result + 2;
    })

    /** 생성자 */
    function Item(title, price) {
        this.title = title;
        this.price = price;
        this.showPrice = function() {
            console.log('가격은 ${price}원 입니다.')
        };
    }

    const item1 = new Item('인형',  3000);
    const item2 = new Item('가방',  4000);
    const item3 = new Item('지갑',  9000);

    console.log(item1, item2, item3);

    item1.showPrice();
</script>