import os  
from datetime import datetime  
import re  
import shutil  
  
def naming(folder_path):  
    for (path, dir, files) in os.walk(folder_path):  
        for filename in files:  
          filepath = os.path.join(path, filename)  
          new_filename = datetime.today().strftime('%Y-%m-%d') + '-' + filename  
          new_filename = os.path.join(path, new_filename)  
          print(filepath)  
          print(new_filename)  
          os.rename(filepath, new_filename)  
          print("끝")  
  
def link(folder_path):  
    for (path, dir, files) in os.walk(folder_path):  
        for filename in files:  
            filepath = os.path.join(path, filename)  
            try:  
                with open(filepath, 'rt', encoding='UTF8') as file:  
                    content = file.read()  
                # 패턴 변경  
                pattern = r'\[\[([^\[\]]+)\]\]'  
                replaced_content = re.sub(pattern, lambda x: '[' + re.sub(r'.*\|', '', x.group(1)).split('/')[-1] + '](https://sonjh919.github.io/posts/' + re.sub(r'.*\|', '', x.group(1).split('/')[-1].replace(' ', '-') + ')'), content)  
                with open(filepath, 'w', encoding='UTF8') as file:  
                    # 수정된 내용 파일에 쓰기  
                    file.write(replaced_content)  
  
                print("링크가 완료되었습니다.")  
  
            except Exception as e:  
                print(f"오류 발생: {e}")  
  
def copyImg():  
    src = 'C:/Users/JH.SON/Desktop/SecondBrain/Archive/img'  
    dst = 'C:/Users/JH.SON/Desktop/sonjh919.github.io/assets/img/IMG'  
    shutil.rmtree(dst)  
    os.mkdir(dst)  
    shutil.copytree(src, dst)  
    print("이미지 복사 완료")  
  
def copyFile():  
    src = 'C:/Users/JH.SON/Desktop/SecondBrain/Project/'  
    dst = 'C:/Users/JH.SON/Desktop/sonjh919.github.io/_posts/temp'  
    shutil.rmtree(dst)  
    shutil.copytree(src, dst)  
    print("파일 복사 완료")  
  
def count():  
    folder_path = "C:/Users/JH.SON/Desktop/sonjh919.github.io/_posts/SecondBrain"  
    file_count = sum([len(files) for r, d, files in os.walk(folder_path)])  
    print("blog count : ", file_count)  
    # folder_path = "C:/Users/JH.SON/Desktop/SecondBrain/"  
    # file_count = sum([len(files) for r, d, files in os.walk(folder_path)])    # print("obsidian count : ", file_count)  
temp_path = "C:/Users/JH.SON/Desktop/sonjh919.github.io/_posts/temp/" #여기서  
# naming(temp_path)  
# link(temp_path)  
copyImg()  
# copyFile()  
# count()