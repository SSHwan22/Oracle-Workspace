/*
    SUBQUERY(서브쿼리)
    하나의 주되 SQL(SELECT, CREATE, UPDATE, INSERT) 안에 포함된 또 하나의 SELECT문
    
    메인 SQL문을 위해서 보조 역할을 하는 SELECT문
    -> 주로 조건절 안에서 쓰임.
*/
-- 간단 서브쿼리 예시 1
-- 노옹철 사원과 같은 부서인 사원들
-- 1) 먼저 노옹철 사원의 부서코드를 조회.
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 2) 부서코드가 D9인 사원들 조회.
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 위의 두 단계를 하나로 합치기.(서브쿼리를 이용해서)
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- 두번째 예시
-- 전체 사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번, 이름, 직급코드를 조회.
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE);

/*
    서브쿼리 구분
    서브쿼리를 수행한 결과값이 몇 행 몇 열이냐에 따라서 분류가 됨.
    - 단일행 (단일열) 서브쿼리 : 서브쿼리를 수행한 결과값이 오직 1개일 때 (한 칸의 칼럼값으로 나올 때)
    - 다중행 (단일열) 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 행일 떄
    - 단일행 (다중열) 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 열일 때
    - 다중행 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러행 여러열일 때
    
    => 서브쿼리를 수행한 결과가 몇 행 몇 열이냐에 따라 사용가능한 연산자가 달라진다.
*/
/*
    1. 단일행 (단일열) 서브쿼리 (SINGLE ROW SUBQUERY)
    서브쿼리의 조회결과값이 오직 1개일 때
    
    일반연산자 사용가능( =, !=, >, <, >=, <= ...)
*/
-- 전 직원의 평군 급여보다 더 적게받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE); -- 결과값이 1행 1열일 때, 오로지 1개의 값

-- 최저급여를 받는 사원의 사번, 사원명, 직급코드, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- 부서별 급여 합이 가장 큰 부서 하나만을 조회, 부서코드, 부서명, 급여 합
-- 1) 각 부서별 급여 합 구하기 + 가장 큰 합을 찾기
-- 2) 1단계 가지고 서브쿼리 만들기
SELECT DEPT_CODE, DEPT_TITLE, SUM(SALARY) 
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
GROUP BY DEPT_CODE, DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);

/*
    2. 다중 행 서브쿼리(Multi Row SUBQUERY)
    서브쿼리의 조회 결과값이 여러 행일 경우
    - IN(10,20,30,...) 서브쿼리 : 여러 개의 결과값중에서 하나라도 일치하는 것이 있다면 / NOT IN(일치하는것이 없을때)
    - > ANY(10,20,30,...) : 여러 개의 결과 값중에서 "하나라도" 클 경우 즉, 여러 개의 결과값중에서 가장 작은 값보다 클 경우
    - < ANY(10,20,30,...) : 여러개의 결과 값중에서 "하나라도" 작을 경우 즉, 여러 개의 결과값중에서 가장 큰 값보다 작을 경우
    
    - > ALL : 여러 개의 결과값의 모든 값보다 클경우
              즉, 여러 개의 결과값중에서 가장 큰 값보다 클 경우
    - < ALL : 여러 개의 결과값의 모든 값보다 작을 경우
              즉, 여러 개의 결과값중에서 가장 작은값보다 작을 경우
*/
-- 각 부서별 최고급여를 받는 사원의 이름, 직급코드, 급여조회
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 위의 급여를 받는 사원을 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN(SELECT MAX(SALARY)
                FROM EMPLOYEE
                GROUP BY DEPT_CODE);
                

