# [Gamsung Camping](https://github.com/ohchangyeol/gamsung-project)
> 방역 체계를 전환하는 ‘위드 코로나’가 시행되었지만 여전히 사람이 대거 몰리는 관광지나 숙소는 꺼려하는 이들이 많고, 이로인하여 도심보단 자연속에서의 감성 추억을 위한 캠핑에 대한 수요가 몰리고 있다.

<br/>

❓ **Problem :** 캠핑장비의 경우 수요에 따라 공급이 부족한 경우가 많아 캠핑 용품 품귀현상이 자주 발생하며 중고 제품을 구매하는 소비자가 증가하고 또한 중고거래 피해도 증가하고 았다.

💡 **Idea :** 중고사기 피해를 방지하고, 만족하는 금액으로 거래 할 수 있으면 좋지 않을까?

📝 **Solution :** 중고 물품 거래를 경매로 진행하여, 수요 공급자 간의 거래 만족도 상승과 화상채팅을 통한 중고 사기 피해를 방지한다.

<br/>

## 담당파트 주요 기능

- **상품 정보 :** Jsoup을 이용한 크롤링, Naver 검색 API를 이용하여 총 2개의 목록을 구성하였다.
- **상품 등록, 수정, 삭제 :** 중고거래를 희망하는 상품을 등록하고, 수정하며 삭제할 수 있다.
- **상품 목록 조회 :** 상품 목록을 가격 가격, 조회수, 입찰 인원 수로 정렬 가능하며, 상품 명으로 검색 가능하다.
- **경매 기능 :** 입찰, 낙찰, 유찰, 낙찰 취소, 중도 철회 등의 기능을 구현하였으며, SockJS와 Stomp를 이용하여 실시간 서비스를 구현하였다.
- **알림 기능 :** Spring Scheduler를 이용하여 낙찰자가 발생할 경우 JavaMail을 이용하여 화상채팅 링크를 발송하도록 구현하였다.
- **리뷰 CRUD :** 경매를 확정 지었을때 리뷰를 등록 수정 삭제하도록 구현하였다.
- **화상 채팅 :** WebRTC와 NodeJs Express SocketIO 를 이용하여 간단한 실시간 화상 채팅을 구현하였다.
- **배포 :** 화상채팅은 인증된 도메인이거나 사용자의 미디어를 잡아올 수 있어 AWS EC2 Micro Server에 배포하였다. 
- **SSL :** Let's Crypto를 이용하여 Express서버에 SSL을 적용하고, LoadBalancer와 AWS Certificate Manager를 이용하여 배포한 Tomcat서버에 간단하게 SSL을 적용하였다.
- **DB :** 교육기간 동안에는 Oracle을 이용하여 수업을 진행하였으나, Mysql 또한 경험해보고 싶어 채택하였고, DB관리자를 담당하였다.
- **Infra :** 프로젝트의 전체 구조를 담당하여 설계하고 구성하였다.
- **ETC :** 마이페이지, 관리자 페이지 등 간단한 CRUD를 구현하였다.

<br/>

## 담당 파트 메인 로직

**1.** 상품을 조회할 경우 크롤링 데이터, Naver API를 이용하여 상품 데이터를 구성하였다.  
**2.** 조회수의 경우 동일한 ip혹은 동일 접속자일 경우의 상황을 고려하여 중복을 제거하여 구현하였다.  
**3.** SockJS와 Stomp를 이용하여 publisher와 subscriber 간의 실시간 데이터 교환이 이루어지도록 구현하였다.  
**4.** 경매 마감시간에 도달한 경우 Spring Scheduler를 통해 경매 상태를 자동으로 변경 시키고, 판매자와 낙찰자에게 화상채팅 링크를 발송한다.  
**5.** WebRTC를 이용하여 1:1 화상채팅을 구현하였다.  

<br/>

## 담당 파트 영상

https://user-images.githubusercontent.com/71271289/154849976-c2a1dc64-e331-4761-bd17-a1f2545bd9b8.mp4

https://user-images.githubusercontent.com/71271289/154849963-83767fd4-ed19-4999-aa88-9d154ff93dc9.mp4

https://user-images.githubusercontent.com/71271289/154850050-6622df09-6b95-4050-8ce8-174ed416ad61.mp4

https://user-images.githubusercontent.com/71271289/154850142-73ce71f7-bd78-4a4d-b604-335a17265f24.mp4

https://user-images.githubusercontent.com/71271289/154850206-8d662b5a-ea83-465b-9e7a-5e3ab7813974.mp4

<br/>

## 담당 파트 화면

![image](https://user-images.githubusercontent.com/71271289/154848512-8c651eee-00b0-4dbf-8ae5-c585d0f32c7d.png)

![image](https://user-images.githubusercontent.com/71271289/154848671-1eacd201-147e-4436-a1a9-38448e2f993a.png)

![image](https://user-images.githubusercontent.com/71271289/154848822-78ea14d3-c078-4fe6-a13c-47d7ce20bb8f.png)

<br/>

## 설계
### :information_desk_person: Class Diagram

![image](https://user-images.githubusercontent.com/71271289/154793736-91e10b5c-5368-4b62-b925-fdddfb15a4a5.png)

### :information_desk_person: VOPC

![image](https://user-images.githubusercontent.com/71271289/154793702-f700ebe9-963f-4a2d-b1b9-d83e32b2b028.png)

### :information_desk_person: ERD

![image](https://user-images.githubusercontent.com/71271289/154793746-34a55df8-3579-4e6c-aef1-7fe810f339b4.png)

### :information_desk_person: Infra

![image](https://user-images.githubusercontent.com/71271289/154793861-50a28165-c823-4e48-bbfe-91917def7001.png)

### :information_desk_person: Tech Stack

![image](https://user-images.githubusercontent.com/71271289/154793969-9ec51eec-7c57-4499-a9c9-a46842237e26.png)

<br/>

## 개발기간

- 2021/12/16 ~ 2022/01/23 (5주)

<br/>

## 프로젝트

- **보고서**

https://drive.google.com/file/d/1T1SRNyecBj8ZWshN6k-mmXbhiOrbcY8j/view?usp=sharing

- **PPT**

https://docs.google.com/presentation/d/1sK73NE-SXzq4q4xNc6ggsNBF73vUhxtW/edit?usp=sharing&ouid=113422004228714150352&rtpof=true&sd=true

<br/>

## 팀원 및 역할 분담
**임준희[본인]** 
  * 경매
  * 화상채팅
  * Infra 구조 설계 및 배포
  * 화면구현
  
**박철홍**
  * 캠핑장(일반 회원)
  * 화면구현

**최인규**
  * 캠핑장(사업자 회원)
  * 결제관리
  * 화면구현

**최정아**
  * 서비스 공급 관리
  * 회원관리
  * 화면구현
  
**황현지**
  * 커뮤니티
  * 예약양도양수
  * 화면구현
 
**오창열**
  * 고객지원
  * 채팅
  * 화면 구현

<br/>
