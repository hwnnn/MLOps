# 우분투 최신 버전의 베이스 이미지를 사용한다.
FROM ubuntu:latest

# 유지 관리자 정보를 레이블로 추가한다.
LABEL maintainer="hwnnn <2020112023@dgu.ac.kr>"

# 작업 디렉토리를 설정한다.
WORKDIR /mlops

# 현재 디렉토리의 모든 파일을 작업 디렉토리로 복사한다.
COPY . .

# 파이썬을 설치한다.
RUN apt-get update \
  && apt-get install -y python3 python3-pip python3-venv

# 의존성을 설치하고 가상 환경 생성
RUN python3 -m venv /mlops/venv \
  && /mlops/venv/bin/pip install --upgrade pip \
  && /mlops/venv/bin/pip install fastapi uvicorn \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# PATH 설정해서 venv 사용
ENV PATH="/mlops/venv/bin:$PATH"

# 애플리케이션이 사용하는 포트를 노출한다.
EXPOSE 80

# main.py를 실행한다.
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]