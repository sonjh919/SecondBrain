### Question
그 "특정 횟수"를 JVM에서는 뭐라고 부르는지 아시나요? 그리고 그 값은 보통 어느 정도로 설정되어 있나요?

### Answer
(이 질문에 대한 직접적인 답변 없이 다음 질문으로 넘어감)

### Feedback
이 용어를 모르는 것은 괜찮지만, 면접에서는 "정확한 용어는 기억나지 않지만, 개념적으로는 이런 것이다"라고 솔직하게 말하는 것이 좋습니다.

### Recommendation
"정확한 용어가 바로 떠오르지 않는데... (잠시 생각) Threshold 같은 이름이었던 것 같습니다."

정답은 **Tenuring Threshold** 또는 **MaxTenuringThreshold**입니다. 

JVM에서 객체가 Survivor 영역을 오갈 때마다 Age가 1씩 증가하고, 이 Age가 MaxTenuringThreshold 값에 도달하면 Old 영역으로 승격됩니다. 기본값은 GC 종류에 따라 다르지만, G1GC의 경우 기본값은 15입니다.

참고로 -XX:MaxTenuringThreshold 옵션으로 이 값을 조정할 수 있으며, 0으로 설정하면 Eden에서 바로 Old로 승격됩니다.
