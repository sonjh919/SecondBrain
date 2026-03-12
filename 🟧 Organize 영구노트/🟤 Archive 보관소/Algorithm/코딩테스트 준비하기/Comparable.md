백준 10825
```java
import java.io.BufferedReader;  
import java.io.BufferedWriter;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.io.OutputStreamWriter;  
import java.util.Arrays;  
import java.util.StringTokenizer;  
  
public class Main {  
  
    public static void main(String[] args) throws IOException {  
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));  
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(System.out));  
        StringTokenizer st;  
  
        // input  
        int N = Integer.parseInt(br.readLine());  
  
        Score[] score = new Score[N];  
        for (int i = 0; i < N; i++) {  
            st = new StringTokenizer(br.readLine());  
            score[i] = new Score(st.nextToken(), Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken()),  
                    Integer.parseInt(st.nextToken()));  
        }  
  
        Arrays.sort(score);  
  
        for (int i = 0; i < N; i++) {  
            bw.write(score[i].name + "\n");  
        }  
  
        // output  
        bw.flush();  
        br.close();  
        bw.close();  
    }  
  
    private static class Score implements Comparable<Score> {  
        String name;  
        int korean;  
        int english;  
        int math;  
  
        public Score(final String name, final int korean, final int english, final int math) {  
            this.name = name;  
            this.korean = korean;  
            this.english = english;  
            this.math = math;  
        }  
  
        @Override  
        public int compareTo(final Score o) {  
            // 문제 기준: 내림차순 > 오름차순 > 내림차순 > 이름 오름차순  
            if (this.korean != o.korean) {  
                return o.korean - this.korean;  // 국어 내림차순  
			}  
            if (this.english != o.english) {  
                return this.english - o.english; // 영어 오름차순  
            }  
            if (this.math != o.math) {  
                return o.math - this.math; // 수학 내림차순  
            }  
            return this.name.compareTo(o.name); // 이름 오름차순  
        }  
    }  
}
```

결과가 음수면 this(왼쪽)이 먼저 오고, 0이면 순서 그대로고, 양수면 o(오른쪽)이 먼저 온다.  
= 반환값이 음수면 위치를 바꾸지 않고, 양수면 위치를 바꾼다.

|표현식|정렬 방식|높은 숫자가 앞으로?|
|---|---|---|
|`o.korean - this.korean`|내림차순|네 (높은 점수, 높은 값이 앞)|
|`this.korean - o.korean`|오름차순|아니오 (낮은 점수가 앞)|

### ex) 예시:

- `this.korean = 90`, `o.korean = 80`인 경우를 생각해봅시다.
    
java

`return o.korean - this.korean; // 80 - 90 = -10`

- 반환값이 **음수(-10)** 이므로, **this**가 자리를 그대로 유지하고 앞으로 갑니다.
    
- 즉, **점수가 높은 학생이 앞에 정렬**됩니다.  
    반대로 오름차순(작은 값부터 정렬)으로 정렬하려면 `this.korean - o.korean`를 써야 합니다.