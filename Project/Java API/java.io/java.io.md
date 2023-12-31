---
title: java.io
date: 2023-12-29 12:26
categories:
  - JavaAPI
  - java.io
tags:
  - JavaAPI
  - Java
  - javaio
image: 
path:
---

## 🌈 java.io
+ Java에서 입출력(io) 작업을 위한 클래스들을 제공한다.
+ **데이터 스트림, 직렬화 및 파일 시스템을 통한 시스템 입력 및 출력을 제공**한다.

### 📌 stream
+ Java에서는 파일이나 콘솔의 입출력을 직접 다루지 않고, stream(스트림)이라는 흐름을 통해 다룬다.
+ stream은 실제의 입력이나 출력이 표현된 **데이터의 이상화된 흐름**을 의미한다.
+ os에 의해 생성되는 가상의 연결 고리를 의미하며, 중간 매개자 역할을 한다.

### 📌 입출력 스트림
+ 스트림은 **한 방향으로만 통신**할 수 있으므로, 입력과 출력을 동시에 처리할 수는 없다.
+ 따라서 스트림은 사용 목적에 따라, 처리 단위에 따라 InputStream & OutputStream / Reader & Writer로 분류된다.
+ InputStream와 Reader 클래스에는 **read()** 메서드가, OutputStream와 Writer 클래스에는 **write()** 메서드가 각각 추상 클래스로 포함되어 있다.

> 바이트 단위로 스트림을 처리할 때에는 InputStream & OutputStream을 사용하고
> 문자 단위로 스트림을 처리할 때에는 Reader & Writer을 사용하자!
{: .prompt-info }

|클래스|메소드|설명|
|---|---|---|
|InputStream|abstract int read()|해당 입력 스트림으로부터 다음 바이트를 읽어들임.|
||int read(byte[ ] b)|해당 입력 스트림으로부터 특정 바이트를 읽어들인 후, 배열 b에 저장함.|
||int read(byte[ ] b, int off, int len)|해당 입력 스트림으로부터 len 바이트를 읽어들인 후, 배열 b[off]부터 저장함.|
|OutputStream|abstract void write(int b)|해당 출력 스트림에 특정 바이트를 저장함.|
||void write(byte[] b)|열 b의 특정 바이트를 배열 b의 길이만큼 해당 출력 스트림에 저장함.|
||void write(byte[] b, int off, int len)|배열 b[off]부터 len 바이트를 해당 출력 스트림에 저장함.|

> read() 메소드는 해당 입력 스트림에서 더 이상 읽어들일 바이트가 없으면, **-1을 반환**해야 한다.  
그런데 반환 타입을 byte 타입으로 하면, 0부터 255까지의 바이트 정보는 표현할 수 있지만 -1은 표현할 수 없게 되므로 InputStream의 read() 메소드는 반환 타입을 **int형**으로 선언하고 있다.
{: .prompt-tip }

## 🌈 자주 쓰이는 클래스 및 인터페이스
### 📌 바이트 기반 스트림
+ 스트림은 기본적으로 바이트 단위로 데이터를 전송한다.

|입력 스트림|출력 스트림|입출력 대상|
|---|---|---|
|FileInputStream|FileOutputStream|파일|
|ByteArrayInputStream|ByteArrayOutputStream|메모리|
|PipedInputStream|PipedOutputStream|프로세스|
|AudioInputStream|AudioOutputStream|오디오 장치|

### 📌 바이트 기반 보조 스트림
+ Java에서 제공하는 보조 스트림은 실제로 데이터를 주고받을 수는 없지만, 다른 스트림의 기능을 향상시키거나 새로운 기능을 추가해 주는 스트림이다.

|입력 스트림|출력 스트림|입출력 대상|
|---|---|---|
|FilterInputStream|FilterOutputStream|필터를 이용한 입출력|
|BufferedInputStream|BufferedOutputStream|버퍼를 이용한 입출력|
|DataInputStream|DataOutputStream|입출력 스트림으로부터 자바의 기본 타입으로 데이터를 읽어올 수 있게 함.|
|ObjectInputStream|ObjectOutputStream|데이터를 객체 단위로 읽거나, 읽어 들인 객체를 역직렬화시킴.|
|SequenceInputStream|X|두 개의 입력 스트림을 논리적으로 연결함.|
|PushbackInputStream|X|다른 입력 스트림에 버퍼를 이용하여 push back이나 unread와 같은 기능을 추가함.|
|X|PrintStream|다른 출력 스트림에 버퍼를 이용하여 다양한 데이터를 출력하기 위한 기능을 추가함.|

### 📌 문자 기반 스트림
+ 문자 기반 스트림은 기존의 바이트 기반 스트림에서  **InputStream을 Reader로, OutputStream을 Writer로 변경**하여 사용한다.

|입력 스트림|출력 스트림|입출력 대상|
|---|---|---|
|FileReader|FileWriter|파일|
|ByteArrayReader|ByteWriter|메모리|
|PipedReader|PipedWriter|프로세스|
|StringReader|StringWriter|문자열|

### 📌 문자 기반 보조 스트림

|입력 스트림|출력 스트림|입출력 대상|
|---|---|---|
|FilterReader|FilterWriter|필터를 이용한 입출력|
|BufferedReader|BufferedWriter|버퍼를 이용한 입출력|
|PushbackReader|X|다른 입력 스트림에 버퍼를 이용하여 push back이나 unread와 같은 기능을 추가함.|
|X|PrintWriter|다른 출력 스트림에 버퍼를 이용하여 다양한 데이터를 출력하기 위한 기능을 추가함.|