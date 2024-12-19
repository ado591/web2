<%@ page import="servlets.AreaCheckServlet" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Web 2</title>
    <link rel="stylesheet" href="../style/style.css">
</head>
<body>
<table id="main-grid">
    <tr>
        <td id="header-plate" colspan="2">
             <span class="left-aligned">Образцова Анжела Дмитриевна 409260</span>
            <span class="right-aligned">951</span>
        </td>
    </tr>

    <tr>
        <td class="content-plate" id="graph-plate">
            <div class="plate-top">
                <h2 class="plate-top-title">Web 2 Вариант 951</h2>
            </div>
            <div class="container">
                <div class="left-block" id="graph">
                    <section class="block plot-section">
                        <div class="graph">
                            <svg height="300" width="300" xmlns="http://www.w3.org/2000/svg">
                                <!-- Оси со стрелками -->
                                <line stroke="gray" x1="0" x2="300" y1="150" y2="150"></line>
                                <line stroke="gray" x1="150" x2="150" y1="0" y2="300"></line>
                                <polygon fill="black" points="150,0 144,15 156,15" stroke="white"></polygon>
                                <polygon fill="black" points="300,150 285,156 285,144" stroke="white"></polygon>

                                <!-- Засечки -->
                                <line stroke="gray" x1="200" x2="200" y1="155" y2="145"></line>
                                <line stroke="gray" x1="250" x2="250" y1="155" y2="145"></line>

                                <line stroke="gray" x1="50" x2="50" y1="155" y2="145"></line>
                                <line stroke="gray" x1="100" x2="100" y1="155" y2="145"></line>

                                <line stroke="gray" x1="145" x2="155" y1="100" y2="100"></line>
                                <line stroke="gray" x1="145" x2="155" y1="50" y2="50"></line>

                                <line stroke="gray" x1="145" x2="155" y1="200" y2="200"></line>
                                <line stroke="gray" x1="145" x2="155" y1="250" y2="250"></line>

                                <!-- Подписи к засечкам -->
                                <text fill="black" x="195" y="140">R/2</text>
                                <text fill="black" x="248" y="140">R</text>

                                <text fill="black" x="40" y="140">-R</text>
                                <text fill="black" x="90" y="140">-R/2</text>

                                <text fill="black" x="160" y="105">R/2</text>
                                <text fill="black" x="160" y="55">R</text>

                                <text fill="black" x="160" y="205">-R/2</text>
                                <text fill="black" x="160" y="255">-R</text>

                                <text fill="black" x="160" y="10">Y</text>
                                <text fill="black" x="290" y="140">X</text>

                                <!-- Прямоугольники и полигоны -->

                                <!-- Прямоугольник в первой четверти -->
                                <rect x="150" y="100" width="100" height="50" fill="#0000FF" fill-opacity="0.2" stroke="#0000FF"></rect>

                                <!-- Полукруг во второй четверти -->
                                <path d="M 150 55 A 100, 100, 0, 0, 0, 50 150 L 150 150 Z"  fill-opacity="0.2" fill="#0000FF" stroke="#0000FF"></path>

                                <!-- Треугольник в четвертой четверти -->
                                <polygon fill="#0000FF" fill-opacity="0.2" points="150,150 200,150 150,200" stroke="#0000FF"></polygon>

                                <circle cx="150" cy="150" id="target-dot" r="0" stroke="white" fill="white"></circle>
                            </svg>
                        </div>
                    </section>
                </div>
            </div>
        </td>



    </tr>

    <td class="content-plate" id="table-plate" rowspan="2">
        <div class="plate-top">
            <h2 class="plate-top-title">Результаты</h2>
        </div>

        <div class="scroll-container">
            <table id="result-table">
                <tr class="table-header">
                    <th class="coords-col">X</th>
                    <th class="coords-col">Y</th>
                    <th class="coords-col">R</th>
                    <th class="time-col">Текущее время</th>
                    <th class="time-col">Время работы скрипта</th>
                    <th class="hitres-col">Результат</th>
                </tr>

                <tbody id="results">
                <jsp:include page="/jsp/table.jsp"/>
                </tbody>
            </table>
        </div>
    </td>
    <tr>
        <td class="content-plate" id="values-plate">
            <div class="plate-top">
                <h2 class="plate-top-title">Параметры</h2>
            </div>

            <form id="input-form" action="" method="POST">
                <table id="input-grid">
                    <tr>
                        <td class="input-grid-label">
                            <label>X:</label>
                        </td>
                        <td class="input-grid-value radio-group">
                            <div class="center-label">
                                <button type="button" class="x-button" id="x-button1" name="xval" value="-5">-5</button>
                            </div>

                            <div class="center-label">
                                <button type="button" class="x-button" id="x-button2" name="xval" value="-4">-4</button>
                            </div>

                            <div class="center-label">
                                <button type="button" class="x-button" id="x-button3" name="xval" value="-3">-3</button>
                            </div>

                            <div class="center-label">
                                <button type="button" class="x-button" id="x-button4" name="xval" value="-2">-2</button>
                            </div>

                            <div class="center-label">
                                <button type="button" class="x-button" id="x-button5" name="xval" value="-1">-1</button>
                            </div>

                            <div class="center-label">
                                <button type="button" class="x-button" id="x-button6" name="xval" value="0">0</button>
                            </div>

                            <div class="center-label">
                                <button type="button" class="x-button" id="x-button7" name="xval" value="1">1</button>
                            </div>

                            <div class="center-label">
                                <button type="button" class="x-button" id="x-button8" name="xval" value="2">2</button>
                            </div>

                            <div class="center-label">
                                <button type="button" class="x-button" id="x-button9" name="xval" value="3">3</button>
                            </div>


                        </td>
                    </tr>

                    <tr>
                        <td class="input-grid-label">
                            <label>Y:</label>
                        </td>
                        <td class="input-grid-value">
                            <input id="y-text-input" type="text" name="yval" maxlength="10" autocomplete="off"
                                   placeholder="Введите число от -5 до 3...">
                            <div class="notification" class="notification" style="display: none;"></div>
                        </td>
                    </tr>

                    <tr>
                        <td class="input-grid-label">
                            <label>R:</label>
                        </td>
                        <td class="input-grid-value">
                            <input id="r-text-input" type="text" name="rval" maxlength="10" autocomplete="off"
                                   placeholder="Введите число от 1 до 4...">
                            <div class="notification" id="notification" style="display: none;"></div>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <div class="buttons">
                                <input class="button" type="submit" value="Отправить" onclick="onSubmitClick()">
                                <input class="button" type="reset" value="Отмена">
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>



<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="../scripts/script.js"></script>
</body>
</html>