### Question
Minor GC와 Major GC(Full GC)는 각각 언제 발생하고, 성능에 어떤 영향을 주나요?

### Answer
제가 알기로는 Minor GC, Major GC는 크게는 Minor가 조금 작은 GC 작동, Major가 큰 GC 작동 정도라고 알고 있고, Minor GC 같은 경우에는 Eden 영역에 GC, 그리고 Major GC 같은 경우에는 Eden 포함해서 Survivor이나 Old 영역까지 실시를 하는 것이 아닐까 이 정도로 알고 있고, 조금 더 학습해 보도록 하겠습니다.

### Feedback
Minor GC가 Young Generation(Eden + Survivor)을 대상으로 하고, Major/Full GC가 더 큰 범위를 다룬다는 기본 개념은 맞습니다. 다만 정확한 범위와 발생 조건, 그리고 성능 영향에 대한 설명이 부족합니다. 모르는 부분을 솔직히 인정하고 학습하겠다는 태도는 좋습니다.

### Recommendation
"Minor GC는 Young Generation(Eden + Survivor 영역)이 가득 찼을 때 발생합니다. 새로 생성된 객체 대부분은 금방 사라지기 때문에(Weak Generational Hypothesis), Minor GC는 빠르게 끝나고 Stop-the-World 시간도 짧습니다. 보통 수~수십 밀리초 수준입니다.

Major GC(또는 Full GC)는 Old 영역이 가득 찼을 때 발생합니다. Old 영역에는 오래 살아남은 객체들이 있어서 회수 대상이 적고, 영역 크기도 크기 때문에 Minor GC보다 훨씬 오래 걸립니다. Stop-the-World 시간이 수백 밀리초에서 심하면 수 초까지 갈 수 있어서, 이 시간 동안 애플리케이션이 멈추게 됩니다.

성능 관점에서 보면, Minor GC는 자주 발생해도 괜찮지만 Major GC는 가능한 적게 발생하도록 튜닝하는 것이 중요합니다. Major GC가 자주 발생한다면 힙 크기를 늘리거나, 객체 생성 패턴을 점검하거나, GC 알고리즘을 변경하는 것을 고려해야 합니다."
