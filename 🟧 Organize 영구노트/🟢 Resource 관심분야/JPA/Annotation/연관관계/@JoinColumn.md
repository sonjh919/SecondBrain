#jpa #Annotation 

## @JoinColumn
외래 키를 매핑할 때 사용한다. [[@ManyToOne]]과 같이 사용한다. 이 어노테이션은 생략 가능하다.

> [!info]+ 
> [[복합 키]]일 경우 여러 컬럼을 매핑해야 하므로 @JoinColumns를 사용한다.

## 속성
> [!note]+ name
> 매핑할 **외래 키** 이름을 지정한다.
> 
> **기본값**
> 필드명 + _ + 참조하는 테이블의 기본 키 컬럼명

> [!note]+ referencedColumnName
> 외래 키가 참조하는 대상 테이블의 컬럼명
> 
> **기본값**
> 참조하는 테이블의 기본 키 컬럼명

> [!note]+ foreignKey
> 외래 키 제약조건을 직접 지정할 수 있다. 이 속성은 테이블을 생성할 때만 사용한다.

> [!summary]+ 
> unique
> nullable
> insertable
> updateable
> 
> [[@Column]]의 속성과 같다.

> [!tip]+ 
> nullable을 true로 설정할 시 외부 조인을 사용하며, nullable을 false로 설정할 시 내부 조인을 사용한다. 내부 조인이 성능과 최적화 면에서 더 뛰어나므로 고려해보도록 하자.