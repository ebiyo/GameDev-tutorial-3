## Proses Pengerjaan Fitur
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
