require 'integer_linear_program'

class WinterIlp

  def initialize
    puts "Seeding data..."
    seed_instructors
    seed_departments
    seed_courses
    seed_sections
    seed_students
    seed_section_preferences
  end

  def run
    puts "Fetching data..."
    students = User.joins(:section_preferences).students
    sections = Section.joins(course: :department).all

    puts "Running solver..."
    problem = IntegerLinearProgram.new(students, sections)
    problem.solve
    problem.print_results
  end

private

  def seed_instructors
    @instructor = User.create! first_name: "John", last_name: "Doe", email: "instructor@oregonstate.edu"
    @ehsan = User.create! first_name: "Not Present", last_name: "Ehsan", email: "ehsan@oregonstate.edu"
    @christi = User.create! first_name: "Not Present", last_name: "Christi", email: "christi@oregonstate.edu"
    @ahmed = User.create! first_name: "Not Present", last_name: "Ahmed", email: "ahmed@oregonstate.edu"
    @huang = User.create! first_name: "Not Present", last_name: "Huang", email: "huang@oregonstate.edu"
    @termehchy = User.create! first_name: "Not Present", last_name: "Termehchy", email: "termehchy@oregonstate.edu"
    @azarbakht = User.create! first_name: "Not Present", last_name: "Azarbakht", email: "azarbakht@oregonstate.edu"
    @redfield = User.create! first_name: "Not Present", last_name: "Redfield", email: "redfield@oregonstate.edu"
    @ohara = User.create! first_name: "Not Present", last_name: "O'Hara", email: "ohara@oregonstate.edu"
    @jensen = User.create! first_name: "Not Present", last_name: "Jensen", email: "jensen@oregonstate.edu"
    @surisetty = User.create! first_name: "Not Present", last_name: "Surisetty", email: "surisetty@oregonstate.edu"
    @li = User.create! first_name: "Not Present", last_name: "Li", email: "li@oregonstate.edu"
    @dig = User.create! first_name: "Not Present", last_name: "Dig", email: "dig@oregonstate.edu"
    @walkingshaw = User.create! first_name: "Not Present", last_name: "Walkingshaw", email: "walkingshaw@oregonstate.edu"
    @bailey = User.create! first_name: "Not Present", last_name: "Bailey", email: "bailey@oregonstate.edu"
    @sarbaziazad = User.create! first_name: "Not Present", last_name: "Sarbaziazad", email: "sarbaziazad@oregonstate.edu"
  end

  def seed_student_preferences
    @ehsan.student_preferences.create! student: @sherif_abdelwahab, section: @section_225E, value: 4
    @christi.student_preferences.create! student: @ali_aburas, section: @section_362, value: 4
    @ahmed.student_preferences.create! student: @ali_aburas, section: @section_361, value: 3
    @huang.student_preferences.create! student: @james_cross, section: @section_480, value: 4
    @huang.student_preferences.create! student: @dezhong_deng, section: @section_480, value: 4
    @termehchy.student_preferences.create! student: @laxmi_ganesan, section: @section_540, value: 4
    @azarbakht.student_preferences.create! student: @laxmi_ganesan, section: @section_352E, value: 3
    @redfield.student_preferences.create! student: @jake_joseph, section: @section_372E, value: 4
    @ohara.student_preferences.create! student: @jake_joseph, section: @section_391, value: 4
    @ohara.student_preferences.create! student: @kimberly_kaaz, section: @section_391, value: 4
    @redfield.student_preferences.create! student: @paris_kalathas, section: @section_271, value: 4
    @surisetty.student_preferences.create! student: @prashant_kumar, section: @section_290E, value: 4
    @li.student_preferences.create! student: @mingbo_ma, section: @section_519, value: 4
    @ehsan.student_preferences.create! student: @siddarth_mahendra, section: @section_225E, value: 4
    @ahmed.student_preferences.create! student: @ayda_mannan, section: @section_361E, value: 3
    @jensen.student_preferences.create! student: @ayda_mannan, section: @section_352, value: 3
    @dig.student_preferences.create! student: @shane_mckee, section: @section_361, value: 4
    @walkingshaw.student_preferences.create! student: @michael_mcgirr, section: @section_381, value: 4
    @ehsan.student_preferences.create! student: @meng_meng, section: @section_225E, value: 4
    @bailey.student_preferences.create! student: @sean_moore, section: @section_457, value: 4
    @ehsan.student_preferences.create! student: @sean_moore, section: @section_261E, value: 4
    @surisetty.student_preferences.create! student: @bhargav_pandya, section: @section_290E, value: 4
    @walkingshaw.student_preferences.create! student: @chao_peng, section: @section_381, value: 4
    @jensen.student_preferences.create! student: @sean_penney, section: @section_352, value: 4
    @ehsan.student_preferences.create! student: @hamed_shahbazi, section: @section_261E, value: 4
    @ehsan.student_preferences.create! student: @dilruba_showkat, section: @section_261E, value: 4
    @surisetty.student_preferences.create! student: @satpreet_singh, section: @section_290E, value: 4
    @termehchy.student_preferences.create! student: @nitin_subramanian, section: @section_440, value: 4
    @redfield.student_preferences.create! student: @nitin_subramanian, section: @section_372E, value: 4
    @ehsan.student_preferences.create! student: @dimitrios_trigkakis, section: @section_225E, value: 4
    @surisetty.student_preferences.create! student: @chenyu_wang, section: @section_290E, value: 4
    @surisetty.student_preferences.create! student: @haoxiang_wang, section: @section_290E, value: 4
    @sarbaziazad.student_preferences.create! student: @luyao_zhang, section: @section_340E, value: 4
    @li.student_preferences.create! student: @kai_zhou, section: @section_519, value: 4
  end

  def seed_departments
    @computer_science = Department.create! subject_code: "CS"
  end

  def seed_courses
    @course_225 = Course.create! department: @computer_science, course_number: 225
    @course_261 = Course.create! department: @computer_science, course_number: 261
    @course_271 = Course.create! department: @computer_science, course_number: 271
    @course_290 = Course.create! department: @computer_science, course_number: 290
    @course_321 = Course.create! department: @computer_science, course_number: 321
    @course_325 = Course.create! department: @computer_science, course_number: 325
    @course_340 = Course.create! department: @computer_science, course_number: 340
    @course_344 = Course.create! department: @computer_science, course_number: 344
    @course_352 = Course.create! department: @computer_science, course_number: 352
    @course_361 = Course.create! department: @computer_science, course_number: 361
    @course_362 = Course.create! department: @computer_science, course_number: 362
    @course_372 = Course.create! department: @computer_science, course_number: 372
    @course_381 = Course.create! department: @computer_science, course_number: 381
    @course_391 = Course.create! department: @computer_science, course_number: 391
    @course_419 = Course.create! department: @computer_science, course_number: 419
    @course_440 = Course.create! department: @computer_science, course_number: 440
    @course_457 = Course.create! department: @computer_science, course_number: 457
    @course_462 = Course.create! department: @computer_science, course_number: 462
    @course_480 = Course.create! department: @computer_science, course_number: 480
    @course_496 = Course.create! department: @computer_science, course_number: 496
    @course_519 = Course.create! department: @computer_science, course_number: 519
    @course_540 = Course.create! department: @computer_science, course_number: 540
  end

  def seed_sections
    @section_225E = Section.create! course: @course_225, instructor: @instructor, term: "W16", current_enrollment: 181, location: 1
    @section_261 = Section.create! course: @course_261, instructor: @instructor, term: "W16", current_enrollment: 87, location: 0
    @section_261E = Section.create! course: @course_261, instructor: @instructor, term: "W16", current_enrollment: 122, location: 1
    @section_271 = Section.create! course: @course_271, instructor: @instructor, term: "W16", current_enrollment: 111, location: 0
    @section_271E = Section.create! course: @course_271, instructor: @instructor, term: "W16", current_enrollment: 119, location: 1
    @section_290 = Section.create! course: @course_290, instructor: @instructor, term: "W16", current_enrollment: 133, location: 0
    @section_290E = Section.create! course: @course_290, instructor: @instructor, term: "W16", current_enrollment: 143, location: 1
    @section_321 = Section.create! course: @course_321, instructor: @instructor, term: "W16", current_enrollment: 49, location: 0
    @section_325 = Section.create! course: @course_325, instructor: @instructor, term: "W16", current_enrollment: 126, location: 0
    @section_325E = Section.create! course: @course_325, instructor: @instructor, term: "W16", current_enrollment: 75, location: 1
    @section_340 = Section.create! course: @course_340, instructor: @instructor, term: "W16", current_enrollment: 92, location: 1
    @section_344 = Section.create! course: @course_344, instructor: @instructor, term: "W16", current_enrollment: 74, location: 0
    @section_344E = Section.create! course: @course_344, instructor: @instructor, term: "W16", current_enrollment: 86, location: 1
    @section_352 = Section.create! course: @course_352, instructor: @instructor, term: "W16", current_enrollment: 46, location: 0
    @section_352E = Section.create! course: @course_352, instructor: @instructor, term: "W16", current_enrollment: 130, location: 1
    @section_361 = Section.create! course: @course_361, instructor: @instructor, term: "W16", current_enrollment: 33, location: 0
    @section_361E = Section.create! course: @course_361, instructor: @instructor, term: "W16", current_enrollment: 88, location: 1
    @section_362 = Section.create! course: @course_362, instructor: @instructor, term: "W16", current_enrollment: 102, location: 0
    @section_362E = Section.create! course: @course_362, instructor: @instructor, term: "W16", current_enrollment: 64, location: 1
    @section_372 = Section.create! course: @course_372, instructor: @instructor, term: "W16", current_enrollment: 75, location: 0
    @section_372E = Section.create! course: @course_372, instructor: @instructor, term: "W16", current_enrollment: 59, location: 1
    @section_381 = Section.create! course: @course_381, instructor: @instructor, term: "W16", current_enrollment: 62, location: 0
    @section_391 = Section.create! course: @course_391, instructor: @instructor, term: "W16", current_enrollment: 60, location: 0
    @section_391E = Section.create! course: @course_391, instructor: @instructor, term: "W16", current_enrollment: 59, location: 1
    @section_419 = Section.create! course: @course_419, instructor: @instructor, term: "W16", current_enrollment: 33, location: 1
    @section_440 = Section.create! course: @course_440, instructor: @instructor, term: "W16", current_enrollment: 37, location: 0
    @section_457 = Section.create! course: @course_457, instructor: @instructor, term: "W16", current_enrollment: 48, location: 0
    @section_462 = Section.create! course: @course_462, instructor: @instructor, term: "W16", current_enrollment: 124, location: 0
    @section_480 = Section.create! course: @course_480, instructor: @instructor, term: "W16", current_enrollment: 65, location: 0
    @section_496 = Section.create! course: @course_496, instructor: @instructor, term: "W16", current_enrollment: 55, location: 0
    @section_519 = Section.create! course: @course_519, instructor: @instructor, term: "W16", current_enrollment: 60, location: 0
    @section_540 = Section.create! course: @course_540, instructor: @instructor, term: "W16", current_enrollment: 39, location: 0
  end

  def seed_students
    @sherif_abdelwahab = User.create! first_name: "Sherif", last_name: "Abdelwahab", fte: 0.25, email: "sherif_abdelwahab@oregonstate.edu"
    @ali_aburas = User.create! first_name: "Ali", last_name: "Aburas", fte: 0.49, email: "ali_aburas@oregonstate.edu"
    @sahar_alizadeh = User.create! first_name: "Sahar", last_name: "Alizadeh", fte: 0.25, email: "sahar_alizadeh@oregonstate.edu"
    @parisa_sadat_ataei = User.create! first_name: "Parisa Sadat", last_name: "Ataei", fte: 0.49, email: "parisa_sadat_ataei@oregonstate.edu"
    @pooria_azimi = User.create! first_name: "Pooria", last_name: "Azimi", fte: 0.49, email: "pooria_azimi@oregonstate.edu"
    @kaikai_bian = User.create! first_name: "Kaikai", last_name: "Bian", fte: 0.25, email: "kaikai_bian@oregonstate.edu"
    @zehuan_chen = User.create! first_name: "Zehuan", last_name: "Chen", fte: 0.25, email: "zehuan_chen@oregonstate.edu"
    @james_cross = User.create! first_name: "James", last_name: "Cross", fte: 0.25, email: "james_cross@oregonstate.edu"
    @padideh_danaee = User.create! first_name: "Padideh", last_name: "Danaee", fte: 0.49, email: "padideh_danaee@oregonstate.edu"
    @dezhong_deng = User.create! first_name: "Dezhong", last_name: "Deng", fte: 0.25, email: "dezhong_deng@oregonstate.edu"
    @jonathan_dodge = User.create! first_name: "Jonathan", last_name: "Dodge", fte: 0.49, email: "jonathan_dodge@oregonstate.edu"
    @laxmi_ganesan = User.create! first_name: "Laxmi", last_name: "Ganesan", fte: 0.49, email: "laxmi_ganesan@oregonstate.edu"
    @xiaofei_gao = User.create! first_name: "Xiaofei", last_name: "Gao", fte: 0.25, email: "xiaofei_gao@oregonstate.edu"
    @reza_ghaeini = User.create! first_name: "Reza", last_name: "Ghaeini", fte: 0.25, email: "reza_ghaeini@oregonstate.edu"
    @xinze_guan = User.create! first_name: "Xinze", last_name: "Guan", fte: 0.49, email: "xinze_guan@oregonstate.edu"
    @jun_he = User.create! first_name: "Jun", last_name: "He", fte: 0.49, email: "jun_he@oregonstate.edu"
    @jake_joseph = User.create! first_name: "Jake", last_name: "Joseph", fte: 0.49, email: "jake_joseph@oregonstate.edu"
    @kimberly_kaaz = User.create! first_name: "Kimberly", last_name: "Kaaz", fte: 0.49, email: "kimberly_kaaz@oregonstate.edu"
    @paris_kalathas = User.create! first_name: "Parirs", last_name: "Kalathas", fte: 0.25, email: "paris_kalathas@oregonstate.edu"
    @prashant_kumar = User.create! first_name: "Prashant", last_name: "Kumar", fte: 0.49, email: "prashant_kumar@oregonstate.edu"
    @thi_kim_phung_lai = User.create! first_name: "Thi Kim Phung", last_name: "Lai", fte: 0.25, email: "thi_kim_phung_Lai@oregonstate.edu"
    @dapeng_li = User.create! first_name: "Dapeng", last_name: "Li", fte: 0.25, email: "dapeng_li@oregonstate.edu"
    @yunfan_li = User.create! first_name: "Yunfan", last_name: "Li", fte: 0.25, email: "yunfan_li@oregonstate.edu"
    @daniel_lin = User.create! first_name: "Daniel", last_name: "Lin", fte: 0.49, email: "daniel_lin@oregonstate.edu"
    @juan_liu = User.create! first_name: "Juan", last_name: "Liu", fte: 0.25, email: "juan_liu@oregonstate.edu"
    @mingbo_ma = User.create! first_name: "Mingbo", last_name: "Ma", fte: 0.49, email: "mingbo_ma@oregonstate.edu"
    @siddarth_mahendra = User.create! first_name: "Siddarth", last_name: "Mahendra", fte: 0.25, email: "siddarth_mahendra@oregonstate.edu"
    @ayda_mannan = User.create! first_name: "Ayda", last_name: "Mannan", fte: 0.49, email: "ayda_mannan@oregonstate.edu"
    @shane_mckee = User.create! first_name: "Sane", last_name: "Mc Kee", fte: 0.49, email: "sane_mc_kee@oregonstate.edu"
    @michael_mcgirr = User.create! first_name: "Michael", last_name: "McGirr", fte: 0.25, email: "michael_mcgirr@oregonstate.edu"
    @meng_meng = User.create! first_name: "Meng", last_name: "Meng", fte: 0.25, email: "meng_meng@oregonstate.edu"
    @erich_merrill = User.create! first_name: "Erich", last_name: "Merrill", fte: 0.25, email: "erich_merrill@oregonstate.edu"
    @sean_moore = User.create! first_name: "Sean", last_name: "Moore", fte: 0.49, email: "sean_moore@oregonstate.edu"
    @thi_tam_nguyen = User.create! first_name: "Thi Tam", last_name: "Nguyen", fte: 0.25, email: "thi_tam_nguyen@oregonstate.edu"
    @rasha_obeidat = User.create! first_name: "Rasha", last_name: "Obeidat", fte: 0.25, email: "rasha_obeidat@oregonstate.edu"
    @nels_oscar = User.create! first_name: "Nels", last_name: "Oscar", fte: 0.49, email: "nels_oscar@oregonstate.edu"
    @junjie_pan = User.create! first_name: "Junjie", last_name: "Pan", fte: 0.25, email: "junjie_pan@oregonstate.edu"
    @bhargav_pandya = User.create! first_name: "Bhargav", last_name: "Pandya", fte: 0.49, email: "bhargav_pandya@oregonstate.edu"
    @chao_peng = User.create! first_name: "Chao", last_name: "Peng", fte: 0.25, email: "chao_peng@oregonstate.edu"
    @sean_penney = User.create! first_name: "Sean", last_name: "Penney", fte: 0.49, email: "sean_penney@oregonstate.edu"
    @shajith_ravi = User.create! first_name: "Shajith", last_name: "Ravi", fte: 0.49, email: "shajith_ravi@oregonstate.edu"
    @chris_schultz = User.create! first_name: "Chris", last_name: "Schultz", fte: 0.25, email: "chris_schultz@oregonstate.edu"
    @hamed_shahbazi = User.create! first_name: "Hamed", last_name: "Shahbazi", fte: 0.25, email: "hamed_shahbazi@oregonstate.edu"
    @yifan_shen = User.create! first_name: "Yifan", last_name: "Shen", fte: 0.25, email: "yifan_shen@oregonstate.edu"
    @dilruba_showkat = User.create! first_name: "Dilruba", last_name: "Showkat", fte: 0.49, email: "dilruba_showkat@oregonstate.edu"
    @satpreet_singh = User.create! first_name: "Satpreet", last_name: "Singh", fte: 0.49, email: "satpreet_singh@oregonstate.edu"
    @nitin_subramanian = User.create! first_name: "Nitin", last_name: "Subramanian", fte: 0.49, email: "nitin_subramanian@oregonstate.edu"
    @dimitrios_trigkakis = User.create! first_name: "Dimitrios", last_name: "Trigkakis", fte: 0.49, email: "dimitrios_trigkakis@oregonstate.edu"
    @chenyu_wang = User.create! first_name: "Chenyu", last_name: "Wang", fte: 0.25, email: "chenyu_wang@oregonstate.edu"
    @haoxiang_wang = User.create! first_name: "Haoxiang", last_name: "Wang", fte: 0.25, email: "haoxiang_wang@oregonstate.edu"
    @farzad_zafarani = User.create! first_name: "Farzad", last_name: "Zafarani", fte: 0.49, email: "farzad_zafarani@oregonstate.edu"
    @he_zhang = User.create! first_name: "He", last_name: "Zhang", fte: 0.49, email: "he_zhang@oregonstate.edu"
    @luyao_zhang = User.create! first_name: "Luyao", last_name: "Zhang", fte: 0.25, email: "luyao_zhang@oregonstate.edu"
    @kai_zhou = User.create! first_name: "Kai", last_name: "Zhou", fte: 0.25, email: "kai_zhou@oregonstate.edu"
  end

  def seed_section_preferences
    @sherif_abdelwahab.section_preferences.create! section: @section_225E, value: 4
    @ali_aburas.section_preferences.create! section: @section_261, value: 3
    @ali_aburas.section_preferences.create! section: @section_261E, value: 3
    @ali_aburas.section_preferences.create! section: @section_290, value: 3
    @ali_aburas.section_preferences.create! section: @section_290E, value: 3
    @ali_aburas.section_preferences.create! section: @section_340, value: 3
    @ali_aburas.section_preferences.create! section: @section_344, value: 4
    @ali_aburas.section_preferences.create! section: @section_344E, value: 4
    @ali_aburas.section_preferences.create! section: @section_352, value: 3
    @ali_aburas.section_preferences.create! section: @section_352E, value: 3
    @ali_aburas.section_preferences.create! section: @section_361, value: 4
    @ali_aburas.section_preferences.create! section: @section_361E, value: 4
    @ali_aburas.section_preferences.create! section: @section_362, value: 4
    @ali_aburas.section_preferences.create! section: @section_362E, value: 4
    @ali_aburas.section_preferences.create! section: @section_391, value: 3
    @ali_aburas.section_preferences.create! section: @section_391E, value: 3
    @sahar_alizadeh.section_preferences.create! section: @section_225E, value: 3
    @sahar_alizadeh.section_preferences.create! section: @section_261, value: 4
    @sahar_alizadeh.section_preferences.create! section: @section_261E, value: 4
    @sahar_alizadeh.section_preferences.create! section: @section_290, value: 3
    @sahar_alizadeh.section_preferences.create! section: @section_290E, value: 3
    @sahar_alizadeh.section_preferences.create! section: @section_340, value: 3
    @sahar_alizadeh.section_preferences.create! section: @section_352, value: 4
    @sahar_alizadeh.section_preferences.create! section: @section_352E, value: 4
    @sahar_alizadeh.section_preferences.create! section: @section_372, value: 4
    @sahar_alizadeh.section_preferences.create! section: @section_372E, value: 4
    @sahar_alizadeh.section_preferences.create! section: @section_391, value: 3
    @sahar_alizadeh.section_preferences.create! section: @section_391E, value: 3
    @sahar_alizadeh.section_preferences.create! section: @section_457, value: 3
    @parisa_sadat_ataei.section_preferences.create! section: @section_325, value: 4
    @parisa_sadat_ataei.section_preferences.create! section: @section_325E, value: 4
    @parisa_sadat_ataei.section_preferences.create! section: @section_340, value: 4
    @parisa_sadat_ataei.section_preferences.create! section: @section_361, value: 3
    @parisa_sadat_ataei.section_preferences.create! section: @section_361E, value: 3
    @parisa_sadat_ataei.section_preferences.create! section: @section_372, value: 3
    @parisa_sadat_ataei.section_preferences.create! section: @section_372E, value: 3
    @parisa_sadat_ataei.section_preferences.create! section: @section_440, value: 4
    @pooria_azimi.section_preferences.create! section: @section_261, value: 3
    @pooria_azimi.section_preferences.create! section: @section_261E, value: 3
    @pooria_azimi.section_preferences.create! section: @section_290, value: 4
    @pooria_azimi.section_preferences.create! section: @section_290E, value: 4
    @pooria_azimi.section_preferences.create! section: @section_340, value: 3
    @pooria_azimi.section_preferences.create! section: @section_344, value: 3
    @pooria_azimi.section_preferences.create! section: @section_344E, value: 3
    @pooria_azimi.section_preferences.create! section: @section_381, value: 4
    @pooria_azimi.section_preferences.create! section: @section_440, value: 3
    @pooria_azimi.section_preferences.create! section: @section_480, value: 3
    @pooria_azimi.section_preferences.create! section: @section_496, value: 4
    @kaikai_bian.section_preferences.create! section: @section_225E, value: 4
    @kaikai_bian.section_preferences.create! section: @section_261, value: 4
    @kaikai_bian.section_preferences.create! section: @section_261E, value: 4
    @kaikai_bian.section_preferences.create! section: @section_271, value: 3
    @kaikai_bian.section_preferences.create! section: @section_271E, value: 3
    @kaikai_bian.section_preferences.create! section: @section_321, value: 4
    @kaikai_bian.section_preferences.create! section: @section_344, value: 3
    @kaikai_bian.section_preferences.create! section: @section_344E, value: 3
    @zehuan_chen.section_preferences.create! section: @section_261, value: 4
    @zehuan_chen.section_preferences.create! section: @section_261E, value: 4
    @zehuan_chen.section_preferences.create! section: @section_321, value: 4
    @zehuan_chen.section_preferences.create! section: @section_344, value: 4
    @zehuan_chen.section_preferences.create! section: @section_344E, value: 4
    @zehuan_chen.section_preferences.create! section: @section_361, value: 3
    @zehuan_chen.section_preferences.create! section: @section_381, value: 4
    @james_cross.section_preferences.create! section: @section_480, value: 4
    @padideh_danaee.section_preferences.create! section: @section_261, value: 4
    @padideh_danaee.section_preferences.create! section: @section_261E, value: 4
    @padideh_danaee.section_preferences.create! section: @section_290, value: 3
    @padideh_danaee.section_preferences.create! section: @section_290E, value: 3
    @padideh_danaee.section_preferences.create! section: @section_325, value: 4
    @padideh_danaee.section_preferences.create! section: @section_325E, value: 4
    @padideh_danaee.section_preferences.create! section: @section_340, value: 4
    @padideh_danaee.section_preferences.create! section: @section_344, value: 3
    @padideh_danaee.section_preferences.create! section: @section_344E, value: 3
    @padideh_danaee.section_preferences.create! section: @section_361, value: 3
    @padideh_danaee.section_preferences.create! section: @section_361E, value: 3
    @padideh_danaee.section_preferences.create! section: @section_381, value: 3
    @dezhong_deng.section_preferences.create! section: @section_480, value: 4
    @jonathan_dodge.section_preferences.create! section: @section_462, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_290, value: 3
    @laxmi_ganesan.section_preferences.create! section: @section_290E, value: 3
    @laxmi_ganesan.section_preferences.create! section: @section_340, value: 3
    @laxmi_ganesan.section_preferences.create! section: @section_352, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_352E, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_361, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_361E, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_362, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_362E, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_440, value: 3
    @laxmi_ganesan.section_preferences.create! section: @section_496, value: 3
    @laxmi_ganesan.section_preferences.create! section: @section_540, value: 3
    @xiaofei_gao.section_preferences.create! section: @section_261, value: 4
    @xiaofei_gao.section_preferences.create! section: @section_261E, value: 4
    @xiaofei_gao.section_preferences.create! section: @section_321, value: 3
    @xiaofei_gao.section_preferences.create! section: @section_325, value: 4
    @xiaofei_gao.section_preferences.create! section: @section_325E, value: 4
    @xiaofei_gao.section_preferences.create! section: @section_344, value: 3
    @xiaofei_gao.section_preferences.create! section: @section_344E, value: 3
    @xiaofei_gao.section_preferences.create! section: @section_361, value: 3
    @xiaofei_gao.section_preferences.create! section: @section_361E, value: 3
    @xiaofei_gao.section_preferences.create! section: @section_381, value: 3
    @xiaofei_gao.section_preferences.create! section: @section_419, value: 4
    @xiaofei_gao.section_preferences.create! section: @section_457, value: 3
    @reza_ghaeini.section_preferences.create! section: @section_225E, value: 3
    @reza_ghaeini.section_preferences.create! section: @section_261, value: 3
    @reza_ghaeini.section_preferences.create! section: @section_261E, value: 3
    @reza_ghaeini.section_preferences.create! section: @section_271, value: 3
    @reza_ghaeini.section_preferences.create! section: @section_271E, value: 3
    @reza_ghaeini.section_preferences.create! section: @section_290, value: 4
    @reza_ghaeini.section_preferences.create! section: @section_290E, value: 4
    @reza_ghaeini.section_preferences.create! section: @section_321, value: 3
    @reza_ghaeini.section_preferences.create! section: @section_325, value: 4
    @reza_ghaeini.section_preferences.create! section: @section_325E, value: 4
    @reza_ghaeini.section_preferences.create! section: @section_340, value: 4
    @reza_ghaeini.section_preferences.create! section: @section_372, value: 3
    @reza_ghaeini.section_preferences.create! section: @section_372E, value: 3
    @reza_ghaeini.section_preferences.create! section: @section_419, value: 3
    @reza_ghaeini.section_preferences.create! section: @section_519, value: 3
    @xinze_guan.section_preferences.create! section: @section_462, value: 4
    @jun_he.section_preferences.create! section: @section_225E, value: 4
    @jun_he.section_preferences.create! section: @section_290, value: 4
    @jun_he.section_preferences.create! section: @section_290E, value: 4
    @jun_he.section_preferences.create! section: @section_325, value: 3
    @jun_he.section_preferences.create! section: @section_325E, value: 3
    @jun_he.section_preferences.create! section: @section_340, value: 4
    @jun_he.section_preferences.create! section: @section_344, value: 3
    @jun_he.section_preferences.create! section: @section_344E, value: 3
    @jake_joseph.section_preferences.create! section: @section_225E, value: 4
    @jake_joseph.section_preferences.create! section: @section_261, value: 3
    @jake_joseph.section_preferences.create! section: @section_261E, value: 3
    @jake_joseph.section_preferences.create! section: @section_271, value: 3
    @jake_joseph.section_preferences.create! section: @section_271E, value: 3
    @jake_joseph.section_preferences.create! section: @section_290, value: 3
    @jake_joseph.section_preferences.create! section: @section_290E, value: 3
    @jake_joseph.section_preferences.create! section: @section_344, value: 3
    @jake_joseph.section_preferences.create! section: @section_344E, value: 3
    @jake_joseph.section_preferences.create! section: @section_352, value: 3
    @jake_joseph.section_preferences.create! section: @section_352E, value: 3
    @jake_joseph.section_preferences.create! section: @section_372, value: 4
    @jake_joseph.section_preferences.create! section: @section_372E, value: 4
    @jake_joseph.section_preferences.create! section: @section_391, value: 4
    @jake_joseph.section_preferences.create! section: @section_391E, value: 4
    @kimberly_kaaz.section_preferences.create! section: @section_340, value: 4
    @kimberly_kaaz.section_preferences.create! section: @section_344, value: 3
    @kimberly_kaaz.section_preferences.create! section: @section_344E, value: 3
    @kimberly_kaaz.section_preferences.create! section: @section_372, value: 4
    @kimberly_kaaz.section_preferences.create! section: @section_372E, value: 4
    @kimberly_kaaz.section_preferences.create! section: @section_391, value: 4
    @kimberly_kaaz.section_preferences.create! section: @section_391E, value: 4
    @kimberly_kaaz.section_preferences.create! section: @section_440, value: 3
    @paris_kalathas.section_preferences.create! section: @section_261, value: 3
    @paris_kalathas.section_preferences.create! section: @section_261E, value: 3
    @paris_kalathas.section_preferences.create! section: @section_271, value: 4
    @paris_kalathas.section_preferences.create! section: @section_271E, value: 4
    @paris_kalathas.section_preferences.create! section: @section_321, value: 4
    @paris_kalathas.section_preferences.create! section: @section_325, value: 3
    @paris_kalathas.section_preferences.create! section: @section_325E, value: 3
    @paris_kalathas.section_preferences.create! section: @section_340, value: 3
    @paris_kalathas.section_preferences.create! section: @section_344, value: 3
    @paris_kalathas.section_preferences.create! section: @section_344E, value: 3
    @paris_kalathas.section_preferences.create! section: @section_361, value: 4
    @paris_kalathas.section_preferences.create! section: @section_361E, value: 4
    @paris_kalathas.section_preferences.create! section: @section_381, value: 3
    @prashant_kumar.section_preferences.create! section: @section_290, value: 4
    @prashant_kumar.section_preferences.create! section: @section_290E, value: 4
    @thi_kim_phung_lai.section_preferences.create! section: @section_225E, value: 4
    @thi_kim_phung_lai.section_preferences.create! section: @section_261, value: 3
    @thi_kim_phung_lai.section_preferences.create! section: @section_261E, value: 3
    @thi_kim_phung_lai.section_preferences.create! section: @section_271, value: 3
    @thi_kim_phung_lai.section_preferences.create! section: @section_271E, value: 3
    @thi_kim_phung_lai.section_preferences.create! section: @section_325, value: 4
    @thi_kim_phung_lai.section_preferences.create! section: @section_325E, value: 4
    @thi_kim_phung_lai.section_preferences.create! section: @section_419, value: 4
    @dapeng_li.section_preferences.create! section: @section_225E, value: 4
    @dapeng_li.section_preferences.create! section: @section_261, value: 4
    @dapeng_li.section_preferences.create! section: @section_261E, value: 4
    @dapeng_li.section_preferences.create! section: @section_325, value: 4
    @dapeng_li.section_preferences.create! section: @section_325E, value: 4
    @yunfan_li.section_preferences.create! section: @section_261, value: 4
    @yunfan_li.section_preferences.create! section: @section_261E, value: 4
    @yunfan_li.section_preferences.create! section: @section_321, value: 3
    @yunfan_li.section_preferences.create! section: @section_325, value: 4
    @yunfan_li.section_preferences.create! section: @section_325E, value: 4
    @yunfan_li.section_preferences.create! section: @section_344, value: 4
    @yunfan_li.section_preferences.create! section: @section_344E, value: 4
    @yunfan_li.section_preferences.create! section: @section_381, value: 3
    @daniel_lin.section_preferences.create! section: @section_261, value: 4
    @daniel_lin.section_preferences.create! section: @section_261E, value: 4
    @daniel_lin.section_preferences.create! section: @section_325, value: 3
    @daniel_lin.section_preferences.create! section: @section_325E, value: 3
    @daniel_lin.section_preferences.create! section: @section_352, value: 3
    @daniel_lin.section_preferences.create! section: @section_352E, value: 3
    @daniel_lin.section_preferences.create! section: @section_361, value: 4
    @daniel_lin.section_preferences.create! section: @section_361E, value: 4
    @daniel_lin.section_preferences.create! section: @section_362, value: 3
    @daniel_lin.section_preferences.create! section: @section_362E, value: 3
    @daniel_lin.section_preferences.create! section: @section_372, value: 4
    @daniel_lin.section_preferences.create! section: @section_372E, value: 4
    @daniel_lin.section_preferences.create! section: @section_381, value: 3
    @daniel_lin.section_preferences.create! section: @section_391, value: 3
    @daniel_lin.section_preferences.create! section: @section_391E, value: 3
    @juan_liu.section_preferences.create! section: @section_225E, value: 4
    @juan_liu.section_preferences.create! section: @section_261, value: 3
    @juan_liu.section_preferences.create! section: @section_261E, value: 3
    @juan_liu.section_preferences.create! section: @section_271, value: 3
    @juan_liu.section_preferences.create! section: @section_271E, value: 3
    @juan_liu.section_preferences.create! section: @section_290, value: 4
    @juan_liu.section_preferences.create! section: @section_290E, value: 4
    @juan_liu.section_preferences.create! section: @section_325, value: 3
    @juan_liu.section_preferences.create! section: @section_325E, value: 3
    @juan_liu.section_preferences.create! section: @section_340, value: 3
    @juan_liu.section_preferences.create! section: @section_361, value: 3
    @juan_liu.section_preferences.create! section: @section_361E, value: 3
    @juan_liu.section_preferences.create! section: @section_419, value: 4
    @mingbo_ma.section_preferences.create! section: @section_519, value: 4
    @siddarth_mahendra.section_preferences.create! section: @section_225E, value: 4
    @ayda_mannan.section_preferences.create! section: @section_261, value: 3
    @ayda_mannan.section_preferences.create! section: @section_261E, value: 3
    @ayda_mannan.section_preferences.create! section: @section_290, value: 3
    @ayda_mannan.section_preferences.create! section: @section_290E, value: 3
    @ayda_mannan.section_preferences.create! section: @section_340, value: 3
    @ayda_mannan.section_preferences.create! section: @section_352, value: 3
    @ayda_mannan.section_preferences.create! section: @section_352E, value: 3
    @ayda_mannan.section_preferences.create! section: @section_361, value: 4
    @ayda_mannan.section_preferences.create! section: @section_361E, value: 4
    @ayda_mannan.section_preferences.create! section: @section_362, value: 4
    @ayda_mannan.section_preferences.create! section: @section_362E, value: 4
    @ayda_mannan.section_preferences.create! section: @section_391, value: 4
    @ayda_mannan.section_preferences.create! section: @section_391E, value: 4
    @ayda_mannan.section_preferences.create! section: @section_440, value: 3
    @shane_mckee.section_preferences.create! section: @section_225E, value: 3
    @shane_mckee.section_preferences.create! section: @section_261, value: 3
    @shane_mckee.section_preferences.create! section: @section_261E, value: 3
    @shane_mckee.section_preferences.create! section: @section_290, value: 4
    @shane_mckee.section_preferences.create! section: @section_290E, value: 4
    @shane_mckee.section_preferences.create! section: @section_340, value: 3
    @shane_mckee.section_preferences.create! section: @section_352, value: 3
    @shane_mckee.section_preferences.create! section: @section_352E, value: 3
    @shane_mckee.section_preferences.create! section: @section_361, value: 4
    @shane_mckee.section_preferences.create! section: @section_361E, value: 4
    @shane_mckee.section_preferences.create! section: @section_362, value: 4
    @shane_mckee.section_preferences.create! section: @section_362E, value: 4
    @shane_mckee.section_preferences.create! section: @section_391, value: 3
    @shane_mckee.section_preferences.create! section: @section_391E, value: 3
    @michael_mcgirr.section_preferences.create! section: @section_271, value: 4
    @michael_mcgirr.section_preferences.create! section: @section_271E, value: 4
    @michael_mcgirr.section_preferences.create! section: @section_290, value: 3
    @michael_mcgirr.section_preferences.create! section: @section_290E, value: 3
    @michael_mcgirr.section_preferences.create! section: @section_340, value: 3
    @michael_mcgirr.section_preferences.create! section: @section_344, value: 4
    @michael_mcgirr.section_preferences.create! section: @section_344E, value: 4
    @michael_mcgirr.section_preferences.create! section: @section_361, value: 3
    @michael_mcgirr.section_preferences.create! section: @section_361E, value: 3
    @michael_mcgirr.section_preferences.create! section: @section_362, value: 3
    @michael_mcgirr.section_preferences.create! section: @section_362E, value: 3
    @michael_mcgirr.section_preferences.create! section: @section_381, value: 4
    @michael_mcgirr.section_preferences.create! section: @section_440, value: 3
    @meng_meng.section_preferences.create! section: @section_225E, value: 4
    @meng_meng.section_preferences.create! section: @section_261, value: 4
    @meng_meng.section_preferences.create! section: @section_261E, value: 4
    @meng_meng.section_preferences.create! section: @section_381, value: 4
    @sean_moore.section_preferences.create! section: @section_261, value: 4
    @sean_moore.section_preferences.create! section: @section_261E, value: 4
    @sean_moore.section_preferences.create! section: @section_290, value: 3
    @sean_moore.section_preferences.create! section: @section_290E, value: 3
    @sean_moore.section_preferences.create! section: @section_340, value: 3
    @sean_moore.section_preferences.create! section: @section_344, value: 3
    @sean_moore.section_preferences.create! section: @section_344E, value: 3
    @sean_moore.section_preferences.create! section: @section_381, value: 3
    @sean_moore.section_preferences.create! section: @section_457, value: 4
    @sean_moore.section_preferences.create! section: @section_480, value: 4
    @sean_moore.section_preferences.create! section: @section_496, value: 3
    @thi_tam_nguyen.section_preferences.create! section: @section_225E, value: 4
    @thi_tam_nguyen.section_preferences.create! section: @section_361, value: 3
    @thi_tam_nguyen.section_preferences.create! section: @section_361E, value: 3
    @thi_tam_nguyen.section_preferences.create! section: @section_372, value: 4
    @thi_tam_nguyen.section_preferences.create! section: @section_372E, value: 4
    @thi_tam_nguyen.section_preferences.create! section: @section_391, value: 3
    @thi_tam_nguyen.section_preferences.create! section: @section_391E, value: 3
    @thi_tam_nguyen.section_preferences.create! section: @section_419, value: 4
    @rasha_obeidat.section_preferences.create! section: @section_225E, value: 3
    @rasha_obeidat.section_preferences.create! section: @section_261, value: 3
    @rasha_obeidat.section_preferences.create! section: @section_261E, value: 3
    @rasha_obeidat.section_preferences.create! section: @section_321, value: 4
    @rasha_obeidat.section_preferences.create! section: @section_325, value: 4
    @rasha_obeidat.section_preferences.create! section: @section_325E, value: 4
    @rasha_obeidat.section_preferences.create! section: @section_340, value: 4
    @rasha_obeidat.section_preferences.create! section: @section_352, value: 3
    @rasha_obeidat.section_preferences.create! section: @section_352E, value: 3
    @rasha_obeidat.section_preferences.create! section: @section_361, value: 3
    @rasha_obeidat.section_preferences.create! section: @section_361E, value: 3
    @rasha_obeidat.section_preferences.create! section: @section_362, value: 3
    @rasha_obeidat.section_preferences.create! section: @section_362E, value: 3
    @nels_oscar.section_preferences.create! section: @section_462, value: 4
    @junjie_pan.section_preferences.create! section: @section_271, value: 4
    @junjie_pan.section_preferences.create! section: @section_271E, value: 4
    @junjie_pan.section_preferences.create! section: @section_391, value: 4
    @junjie_pan.section_preferences.create! section: @section_391E, value: 4
    @junjie_pan.section_preferences.create! section: @section_419, value: 3
    @junjie_pan.section_preferences.create! section: @section_457, value: 4
    @bhargav_pandya.section_preferences.create! section: @section_290, value: 4
    @bhargav_pandya.section_preferences.create! section: @section_290E, value: 4
    @chao_peng.section_preferences.create! section: @section_261, value: 4
    @chao_peng.section_preferences.create! section: @section_261E, value: 4
    @chao_peng.section_preferences.create! section: @section_321, value: 4
    @chao_peng.section_preferences.create! section: @section_325, value: 3
    @chao_peng.section_preferences.create! section: @section_325E, value: 3
    @chao_peng.section_preferences.create! section: @section_344, value: 3
    @chao_peng.section_preferences.create! section: @section_344E, value: 3
    @chao_peng.section_preferences.create! section: @section_381, value: 4
    @chao_peng.section_preferences.create! section: @section_540, value: 3
    @sean_penney.section_preferences.create! section: @section_261, value: 3
    @sean_penney.section_preferences.create! section: @section_261E, value: 3
    @sean_penney.section_preferences.create! section: @section_271, value: 3
    @sean_penney.section_preferences.create! section: @section_271E, value: 3
    @sean_penney.section_preferences.create! section: @section_290, value: 4
    @sean_penney.section_preferences.create! section: @section_290E, value: 4
    @sean_penney.section_preferences.create! section: @section_352, value: 4
    @sean_penney.section_preferences.create! section: @section_352E, value: 4
    @sean_penney.section_preferences.create! section: @section_361, value: 3
    @sean_penney.section_preferences.create! section: @section_361E, value: 3
    @sean_penney.section_preferences.create! section: @section_362, value: 3
    @sean_penney.section_preferences.create! section: @section_362E, value: 3
    @sean_penney.section_preferences.create! section: @section_391, value: 3
    @sean_penney.section_preferences.create! section: @section_391E, value: 3
    @sean_penney.section_preferences.create! section: @section_496, value: 4
    @shajith_ravi.section_preferences.create! section: @section_225E, value: 3
    @shajith_ravi.section_preferences.create! section: @section_261, value: 3
    @shajith_ravi.section_preferences.create! section: @section_261E, value: 3
    @shajith_ravi.section_preferences.create! section: @section_290, value: 3
    @shajith_ravi.section_preferences.create! section: @section_290E, value: 3
    @shajith_ravi.section_preferences.create! section: @section_325, value: 3
    @shajith_ravi.section_preferences.create! section: @section_325E, value: 3
    @shajith_ravi.section_preferences.create! section: @section_340, value: 3
    @shajith_ravi.section_preferences.create! section: @section_361, value: 4
    @shajith_ravi.section_preferences.create! section: @section_361E, value: 4
    @shajith_ravi.section_preferences.create! section: @section_362, value: 4
    @shajith_ravi.section_preferences.create! section: @section_362E, value: 4
    @shajith_ravi.section_preferences.create! section: @section_391, value: 4
    @shajith_ravi.section_preferences.create! section: @section_391E, value: 4
    @chris_schultz.section_preferences.create! section: @section_261, value: 3
    @chris_schultz.section_preferences.create! section: @section_261E, value: 3
    @chris_schultz.section_preferences.create! section: @section_271, value: 3
    @chris_schultz.section_preferences.create! section: @section_271E, value: 3
    @chris_schultz.section_preferences.create! section: @section_352, value: 4
    @chris_schultz.section_preferences.create! section: @section_352E, value: 4
    @chris_schultz.section_preferences.create! section: @section_361, value: 3
    @chris_schultz.section_preferences.create! section: @section_361E, value: 3
    @chris_schultz.section_preferences.create! section: @section_362, value: 3
    @chris_schultz.section_preferences.create! section: @section_362E, value: 3
    @chris_schultz.section_preferences.create! section: @section_381, value: 3
    @chris_schultz.section_preferences.create! section: @section_419, value: 4
    @chris_schultz.section_preferences.create! section: @section_457, value: 4
    @hamed_shahbazi.section_preferences.create! section: @section_261, value: 4
    @hamed_shahbazi.section_preferences.create! section: @section_261E, value: 4
    @hamed_shahbazi.section_preferences.create! section: @section_321, value: 3
    @hamed_shahbazi.section_preferences.create! section: @section_325, value: 4
    @hamed_shahbazi.section_preferences.create! section: @section_325E, value: 4
    @hamed_shahbazi.section_preferences.create! section: @section_340, value: 4
    @hamed_shahbazi.section_preferences.create! section: @section_361, value: 3
    @hamed_shahbazi.section_preferences.create! section: @section_361E, value: 3
    @hamed_shahbazi.section_preferences.create! section: @section_362, value: 3
    @hamed_shahbazi.section_preferences.create! section: @section_362E, value: 3
    @hamed_shahbazi.section_preferences.create! section: @section_381, value: 3
    @hamed_shahbazi.section_preferences.create! section: @section_440, value: 3
    @yifan_shen.section_preferences.create! section: @section_225E, value: 3
    @yifan_shen.section_preferences.create! section: @section_261, value: 4
    @yifan_shen.section_preferences.create! section: @section_261E, value: 4
    @yifan_shen.section_preferences.create! section: @section_271, value: 3
    @yifan_shen.section_preferences.create! section: @section_271E, value: 3
    @yifan_shen.section_preferences.create! section: @section_325, value: 3
    @yifan_shen.section_preferences.create! section: @section_325E, value: 3
    @yifan_shen.section_preferences.create! section: @section_340, value: 4
    @yifan_shen.section_preferences.create! section: @section_344, value: 4
    @yifan_shen.section_preferences.create! section: @section_344E, value: 4
    @yifan_shen.section_preferences.create! section: @section_440, value: 3
    @yifan_shen.section_preferences.create! section: @section_540, value: 3
    @dilruba_showkat.section_preferences.create! section: @section_261, value: 4
    @dilruba_showkat.section_preferences.create! section: @section_261E, value: 4
    @dilruba_showkat.section_preferences.create! section: @section_271, value: 4
    @dilruba_showkat.section_preferences.create! section: @section_271E, value: 4
    @dilruba_showkat.section_preferences.create! section: @section_340, value: 3
    @dilruba_showkat.section_preferences.create! section: @section_381, value: 3
    @dilruba_showkat.section_preferences.create! section: @section_419, value: 4
    @satpreet_singh.section_preferences.create! section: @section_290, value: 4
    @satpreet_singh.section_preferences.create! section: @section_290E, value: 4
    @nitin_subramanian.section_preferences.create! section: @section_290, value: 3
    @nitin_subramanian.section_preferences.create! section: @section_290E, value: 3
    @nitin_subramanian.section_preferences.create! section: @section_340, value: 4
    @nitin_subramanian.section_preferences.create! section: @section_361, value: 4
    @nitin_subramanian.section_preferences.create! section: @section_361E, value: 4
    @nitin_subramanian.section_preferences.create! section: @section_362, value: 3
    @nitin_subramanian.section_preferences.create! section: @section_362E, value: 3
    @nitin_subramanian.section_preferences.create! section: @section_372, value: 4
    @nitin_subramanian.section_preferences.create! section: @section_372E, value: 4
    @nitin_subramanian.section_preferences.create! section: @section_391, value: 3
    @nitin_subramanian.section_preferences.create! section: @section_391E, value: 3
    @nitin_subramanian.section_preferences.create! section: @section_440, value: 3
    @nitin_subramanian.section_preferences.create! section: @section_540, value: 3
    @dimitrios_trigkakis.section_preferences.create! section: @section_225E, value: 4
    @dimitrios_trigkakis.section_preferences.create! section: @section_321, value: 4
    @dimitrios_trigkakis.section_preferences.create! section: @section_325, value: 3
    @dimitrios_trigkakis.section_preferences.create! section: @section_325E, value: 3
    @dimitrios_trigkakis.section_preferences.create! section: @section_361, value: 3
    @dimitrios_trigkakis.section_preferences.create! section: @section_361E, value: 3
    @dimitrios_trigkakis.section_preferences.create! section: @section_362, value: 3
    @dimitrios_trigkakis.section_preferences.create! section: @section_362E, value: 3
    @dimitrios_trigkakis.section_preferences.create! section: @section_381, value: 4
    @chenyu_wang.section_preferences.create! section: @section_261, value: 4
    @chenyu_wang.section_preferences.create! section: @section_261E, value: 4
    @haoxiang_wang.section_preferences.create! section: @section_290, value: 4
    @haoxiang_wang.section_preferences.create! section: @section_290E, value: 4
    @farzad_zafarani.section_preferences.create! section: @section_225E, value: 3
    @farzad_zafarani.section_preferences.create! section: @section_261, value: 3
    @farzad_zafarani.section_preferences.create! section: @section_261E, value: 3
    @farzad_zafarani.section_preferences.create! section: @section_290, value: 4
    @farzad_zafarani.section_preferences.create! section: @section_290E, value: 4
    @farzad_zafarani.section_preferences.create! section: @section_321, value: 4
    @farzad_zafarani.section_preferences.create! section: @section_340, value: 4
    @farzad_zafarani.section_preferences.create! section: @section_344, value: 3
    @farzad_zafarani.section_preferences.create! section: @section_344E, value: 3
    @farzad_zafarani.section_preferences.create! section: @section_372, value: 3
    @farzad_zafarani.section_preferences.create! section: @section_372E, value: 3
    @farzad_zafarani.section_preferences.create! section: @section_440, value: 3
    @he_zhang.section_preferences.create! section: @section_261, value: 3
    @he_zhang.section_preferences.create! section: @section_261E, value: 3
    @he_zhang.section_preferences.create! section: @section_325, value: 3
    @he_zhang.section_preferences.create! section: @section_325E, value: 3
    @he_zhang.section_preferences.create! section: @section_340, value: 3
    @he_zhang.section_preferences.create! section: @section_361, value: 3
    @he_zhang.section_preferences.create! section: @section_361E, value: 3
    @he_zhang.section_preferences.create! section: @section_362, value: 4
    @he_zhang.section_preferences.create! section: @section_362E, value: 4
    @he_zhang.section_preferences.create! section: @section_381, value: 4
    @he_zhang.section_preferences.create! section: @section_391, value: 4
    @he_zhang.section_preferences.create! section: @section_391E, value: 4
    @he_zhang.section_preferences.create! section: @section_419, value: 3
    @luyao_zhang.section_preferences.create! section: @section_271, value: 4
    @luyao_zhang.section_preferences.create! section: @section_271E, value: 4
    @luyao_zhang.section_preferences.create! section: @section_290, value: 4
    @luyao_zhang.section_preferences.create! section: @section_290E, value: 4
    @luyao_zhang.section_preferences.create! section: @section_321, value: 3
    @luyao_zhang.section_preferences.create! section: @section_340, value: 4
    @kai_zhou.section_preferences.create! section: @section_480, value: 4
    @kai_zhou.section_preferences.create! section: @section_519, value: 4
  end

end

ilp = WinterIlp.new
ilp.run
