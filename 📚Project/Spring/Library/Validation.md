---
title: Validation
date: 2024-01-25 10:41
categories:
  - Spring
tags:
  - Spring
image: 
path:
---
#Spring #Library 

## Bean Validation
+ 검증과 관련되어 간편하게 사용할 수 있는 여러 애너테이션을 제공해준다.

| annotation | 설명 |
| ---- | ---- |
| @NotNull | null 불가 |
| @NotEmpty | null, ""불가 |
| @NotBlank | null, "", " " 불가 |
| @Size | 문자 길이 측정 |
| @Max | 최대값 |
| @Min | 최소값 |
| @Positive | 양수 |
| @Negative | 음수 |
| @Email | E-mail 형식 |
| @Pattern | 정규 표현식 |
| @Valid | Validation 적용 |

## BindingResult
- 예외가 발생하면 BindingResult 객체에 오류에 대한 정보가 담긴다.
- 파라미터로 BindingResult 객체를 받아올 수 있다.

```java
@PostMapping("/user/signup")
public String signup(@Valid SignupRequestDto requestDto, BindingResult bindingResult) {
    // Validation 예외처리
    List<FieldError> fieldErrors = bindingResult.getFieldErrors();
    if(fieldErrors.size() > 0) {
        for (FieldError fieldError : bindingResult.getFieldErrors()) {
            log.error(fieldError.getField() + " 필드 : " + fieldError.getDefaultMessage());
        }
        return "redirect:/api/user/signup";
    }

    userService.signup(requestDto);

    return "redirect:/api/user/login-page";
}
```