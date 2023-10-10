# Gunakan gambar Ruby versi 3.0.0 sebagai dasar
FROM ruby:3.0.0

# Set direktori kerja ke /app
WORKDIR /app
ENV TZ=Asia/Tokyo
# Set the timezone for the container
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Tambahkan gemfile dan gemfile.lock ke dalam wadah
COPY Gemfile Gemfile.lock ./
COPY . ./

# Install dependensi Ruby menggunakan bundler
RUN gem install bundler && bundle install

# Install MySQL Client dan Node.js (gunakan default-mysql-client)
RUN apt-get update -qq && apt-get install -y default-mysql-client && curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs

# Install OpenSSH Server
RUN apt-get update && apt-get install -y openssh-server

# Konfigurasi OpenSSH Server
RUN mkdir /var/run/sshd
RUN echo 'root:patti8' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Port yang akan digunakan oleh aplikasi (gantilah jika diperlukan)
EXPOSE 3000

# Port SSH
EXPOSE 22

# Command untuk menjalankan aplikasi dan SSH Server
CMD ["sh", "-c", "/usr/sbin/sshd -D && rails server -b 0.0.0.0"]
