# SQL

* __SQL(Structured Query Language)__ : 구조화 된 질의 언어

  

  * __DDL(Data Definition Language)__ : 데이터 정의 언어

    * __CREATE__ : 데이터 베이스, 테이블, 뷰, 프로시저 등 `생성`

      ```mysql
      CREATE TABLE 테이블(
      	컬럼 DATA_TYPE(SIZE),
      	...
      	CONSTRAINT 제약조건 (컬럼)
      );
      ```

    * __ALTER__ : 데이터 베이스, 테이블, 뷰, 프로시저 등 `수정`

      ```mysql
      ALTER TABLE 테이블 ADD|DROP|MODIFY 컬럼 DATA_TYPE(SIZE);
      ```

    * __DROP__ : 데이터 베이스, 테이블, 뷰, 프로시저 등 `삭제`

      ```mysql
      DROP TABLE 테이블 명;
      DROP DATABASE 데이터베이스 명;
      ```

  

  

  ---

  

  * __DML(Data Manipulation Language)__ : 데이터 조작 언어

    * __SELETE__ : 테이블에서 조건에 맞는 컬럼 조회
    
      ```MYSQL
      SELECT 컬럼 FROM 테이블 WHERE 조건; (BETWEEN, IN, NOT, ANY,..., ORDER BY 컬럼)
      ```
    
    * __INSERT__ : 테이블의 모든 컬럼 도는 특정 컬럼에 값 삽입
    
      ```mysql
      INSERT INTO 테이블 VALUES(모든 컬럼의 값);
      INSERT INTO 테이블(컬럼 , ...) VALUES(명시된 컬럼의 값);
      ```
    
    * __UPDATE__ : 조건 또는 해당 컬럼에 맞는 값 수정
    
      ```MYSQL
      UPDATE 테이블 SET 컬럼 = 값, 컬럼 = 값, ..;
      UPDATE 테이블 SET 컬럼 = 값, 컬럼 = 값, .. WHERE 조건;
      ```
    
    * __DELETE__ : 테이블의 모든 값, 조건에 맞는 값 삭제
    
      ```mysql
      DELETE FROM 테이블;
      DELETE FROM 테이블 WHERE 조건;
      ```
    
      
  
  
  
  ---
  
  * __DCL(Data Control Language)__ : 데이터 제어 언어
    * __COMMIT__ : 실행된 데이터, 트랜잭션을 저장
    * __ROLLBACK__ : 실행된 데이터, 트랜잭션 취소 (마지막 COMMIT으로 되돌아간다.)
    * __GRANT __: DB 권한 부여
    * __RECOKE__ : DB 권한 삭제



---

