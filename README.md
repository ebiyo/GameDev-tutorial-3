## Proses Pengerjaan Fitur (Tutorial 5)
Karena melanjutkan tutorial 3, saya hanya tinggal mengubah dan menambahkan dari tutorial tersebut.

- Mengubah Sprite2D menjadi AnimatedSprite2D dan memilih frame untuk setiap animation
- Menambahkan perubahan sprite ketika jatuh
- Menambahkan suara latar belakang menggunakan AudioStreamPlayer2D
- Menambahkan mob `Bee` dengan membuat scene dengan root node CharacterBody2D
- Membuat `Bee` bergerak secara random ke segala arah dan mengeluarkan suara secara random dengan pitch yang random juga
- Membuat `Spawner` untuk mengespawn `Bee` dengan maksimum 10 lebah pada satu waktu dan akan despawn setelah 15 detik
- Menambahkan area pada `Bee` untuk mendeteksi ketika player menyentuhnya dan membuat `Player` mengeluarkan suara kesakitan dengan menyuruh teman saya untuk me-record di Audacity dan menaikkan pitchnya
- Menambahkan area collision pada bee agar player dapat menggunakannya sebagai platform untuk naik ke platform yang lebih tinggi (yang tidak bisa dijangkau dengan jump biasa)
- Menambahkan easter egg pada platform yang lebih tinggi (hanya sebuah Sprite2D)

## Proses Pengerjaan Fitur (Tutorial 3)
#### Double jump
- Intuisi: karakter dapat loncat 2 kali (tidak lebih), dan dapat loncat lagi setelah menyentuh tanah
- Membuat var `jump_times` yang menyatakan banyak jump yang dapat dilakukan player (awalnya 0)
- Jika menyentuh tanah, reset `jump_times` menjadi 2
- Ketika mengklik Up Arrow, cek apakah player masih memiliki jump (`jump_times` > 0) dan kurangi `jump_times` tiap kali player melakukan jump

#### Crouching
- Intuisi: karakter dapat crouch (jika di lantai) ketika menekan Down Arrow yang menurunkan kecepatan player
- Membuat `crouch_speed` untuk menyetel kecepatan player saat crouch dan `is_crouching` untuk mengecek apakah player sedang crouch atau tidak
- Mengatur keybind crouch pada Project > Project Settings > Input map
- Mengecek apakah player sedang crouch dan sedang di lantai atau tidak dan menyetel kecepatan player

#### Dashing
- Intuisi: karakter dapat bergerak dengan cepat jika menekan Left/Right Arrow dua kali dalam time window yang ditetapkan.
- Membuat variabel `double_tap_window` untuk menentukan batas waktu antara dua penekanan tombol agar dianggap sebagai dash.
- Membuat variabel `last_tap_time_left` dan `last_tap_time_right` untuk menyimpan waktu terakhir tombol ditekan.
- Menggunakan `Input.is_action_just_pressed()` agar sistem hanya mendeteksi momen tombol pertama kali ditekan (bukan saat ditahan).
- Jika selisih waktu antara penekanan sekarang dan sebelumnya kurang dari `double_tap_window`, maka memanggil `fungsi start_dash(direction)`.
- Membuat variabel `is_dashing` dan `dash_timer` untuk mengatur durasi dash.
- Selama `is_dashing` bernilai true, kecepatan horizontal player diatur ke `dash_speed` dan mengabaikan kecepatan berjalan biasa.
- Mengurangi `dash_timer` setiap frame, dan ketika waktunya habis, mengembalikan player ke state dan kecepatan normal.

#### Tampilan Sprite Karakter
- Intuisi: mengganti texture sprite sesuai pergerakan karakter
- Membuat var texture untuk idle, jump, crouch, dan left/right (satu sprite saja untuk setiap state, nanti di flip sesuai arah)
- Mengganti texture pada script dengan mengecek apakah player sedang crouch (`is_crouching`), tidak menyentuh lantai (`not is_on_floor()`), dan kecepatan horizontal (bergerak atau diam)
- Memasukkan gambar texture sesuai var pada Sub-Resources di node Player (CharacterBody2D)
