#!/usr/bin/env python3
import socket
import subprocess

# Создаем сокет для прослушивания порта 8080
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('', 8080))
s.listen(1)

# Создаем сокет для прослушивания порта 8088
s2 = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s2.bind(('', 8088))
s2.listen(1)

# Ждем подключения клиента
while True:
    conn, addr = s.accept()
    print('User connected to 8080', addr)

    # Отправляем клиенту приветствие
    conn.send(b'HTTP/1.1 200 OK\r\n')
    conn.send(b'Content-Type: text/plain\r\n')
    conn.send(b'\r\n')
    conn.send(b'You have started STRESS test\r\n')

    # Запускаем программу "cputest" и получаем ее вывод
    #proc = subprocess.Popen(['top -b -n 1 | head -n 5'], stdout=subprocess.PIPE, shell=True)
    proc = subprocess.Popen(['killall', 'stress'])
    proc = subprocess.Popen(['stress -c `nproc`'], shell=True)

    # Закрываем соединение с клиентом
    conn.close()

    # Проверяем, есть ли подключение к порту 8888
    conn2, addr2 = s2.accept()
    print('User connected to 8088', addr2)

    # Отправляем клиенту сообщение об убийстве процесса cputest
    conn2.send(b'HTTP/1.1 200 OK\r\n')
    conn2.send(b'Content-Type: text/plain\r\n')
    conn2.send(b'\r\n')
    conn2.send(b'You have STOPed stress test \r\n')

    # Убиваем процесс cputest по его pid
    proc = subprocess.Popen(['killall', 'stress'])
    #os.kill(proc.pid, signal.SIGTERM)

    # Закрываем соединение с клиентом
    conn2.close()

