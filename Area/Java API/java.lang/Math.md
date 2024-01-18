---
title: Math
date: 2023-12-29 14:09
categories:
  - JavaAPI
  - java.lang
tags:
  - JavaAPI
  - Java
  - javalang
image: 
path:
---

## Math
+ Java의 수학적인 연산을 수행하기 위한 메서드를 제공하는 클래스이다.
+ 수학 관련 연산을 수행하는 정적(static) 메서드들로 구성되어 있다.

## 자주 쓰이는 메서드

| 메서드                                    | 설명                                                                |
| ----------------------------------------- | ------------------------------------------------------------------- |
| **static double random()**                | 0.0 이상 1.0 미만의 범위에서 임의의 실수 값을 하나 생성하여 반환함. |
| **static double abs(double a)**           | 전달된 값의 절대값을 반환함.                                        |
| **static double ceil(double a)**          | 전달된 double형 값의 소수 부분을 무조건 올리고 반환함.              |
| **static double floor(double a)**         | 전달된 double형 값의소수 부분을 무조건 버리고 반환함.               |
| **static long round(double a)**           | 전달된 값을 소수점 첫째 자리에서 반올림한 정수를 반환함.            |
| **static double rint(double a)**          | 전달된 double형 값과 가장 가까운 정수값을 double형으로 반환함.      |
| **static double max(double a, double b)** | 전달된 두 값을 비교하여 큰 값을 반환함.                             |
| **static double min(double a, double b)** | 전달된 두 값을 비교하여 작은 값을 반환함.                           |
| **static double pow(double a, double b)** | 전달된 두 개의 double형 값을 가지고 제곱 연산을 수행하여 반환함.    |
| **static double sqrt(double a)**          | 전달된 double형 값의 제곱근 값을 반환함.                            |
| static double sin(double a)               | 전달된 double형 값에 해당하는 각각의 삼각 함숫값을 반환함.          |
| static double cos(double a)               |                                                                     |
| static double tan(double a)               |                                                                     |
| static double toDegrees(double angrad)    | 호도법의 라디안 값을 대략적인 육십분법의 각도 값으로 변환함.        |
| static double toRaidans(double angdeg)    | 육십분법의 각도 값을 대략적인 호도법의 라디안 값으로 변환함.        |
| Math.PI                                   | 원주율 π                                                                    |
| Math.E                                          | 자연 로그의 밑인 자연 상수 e                                                                    |
