require 'integer_linear_program'

class SpringIlp

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
    # students = User.joins(:section_preferences).gtas
    # sections = Section.joins(course: :department).all

    students = User.includes([{section_preferences: :section}, :experiences]).gtas
    sections = Section.includes(
      {course: [:requirements, :department]},
      {instructor: :student_preferences}, :section_preferences)
      .with_current_term

    puts "Running solver..."
    problem = IntegerLinearProgram.new(students, sections)
    problem.solve
    puts problem.inspect
    problem.print_results
  end

private

  def seed_instructors
    @instructor = User.create first_name: 'John', last_name: 'Doe', email: 'instructor@oregonstate.edu'

    @zhang = User.create! first_name: "Eugene", last_name: "Zhang", email: "zhang@oregonstate.edu"
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
    @rosulek = User.create! first_name: "Not Present", last_name: "Rosulek", email: "rosulek@oregonstate.edu"
  end

  def seed_student_preferences
    @zhang.student_preferences.create! student: @keeley_abbott, section: @section_340, value: 4
    @mcgrath.student_preferences.create! student: @caius_brindescu, section: @section_444_544, value: 4
    @mcgrath.student_preferences.create! student: @jonathan_dodge, section: @section_463, value: 4
    @azarbakht.student_preferences.create! student: @laxmi_ganesan, section: @section_352E, value: 3
    @wong.student_preferences.create! student: @mohammad_reza_ghaeini, section: @section_331, value: 3
    @mcgrath.student_preferences.create! student: @xinze_guan, section: @section_463, value: 4
    @wong.student_preferences.create! student: @jun_he, section: @section_331, value: 3
    @jensen.student_preferences.create! student: @zahra_iman, section: @section_391, value: 4
    @ehsan.student_preferences.create! student: @zahra_iman, section: @section_391, value: 3
    @azarbakht.student_preferences.create! student: @zahra_iman, section: @section_352E, value: 3
    @wong.student_preferences.create! student: @jeffrey_juozapaitis, section: @section_331, value: 4
    @sarbaziazad.student_preferences.create! student: @prashant_kumar, section: @section_340, value: 4
    @wong.student_preferences.create! student: @xingyi_li, section: @section_331, value: 3
    @ahmed.student_preferences.create! student: @umme_mannan, section: @section_361, value: 4
    @jensen.student_preferences.create! student: @shane_mckee, section: @section_391, value: 4
    @ahmed.student_preferences.create! student: @shane_mckee, section: @section_361, value: 4
    @metoyer.student_preferences.create! student: @sean_moore, section: @section_261, value: 4
    @mcgrath.student_preferences.create! student: @sean_moore, section: @section_444_544, value: 4
    @bailey.student_preferences.create! student: @sean_moore, section: @section_475_575, value: 4
    @jensen.student_preferences.create! student: @rithika_naik, section: @section_391, value: 4
    @metoyer.student_preferences.create! student: @rasha_obeidat, section: @section_261, value: 4
    @mcgrath.student_preferences.create! student: @nels_oscar, section: @section_463, value: 4
    @ehsan.student_preferences.create! student: @hamed_shahbazi, section: @section_261, value: 4
    @redfield.student_preferences.create! student: @xiangyu_wang, section: @section_271, value: 4
    @ehsan.student_preferences.create! student: @keying_xu, section: @section_225E, value: 3
    @ehsan.student_preferences.create! student: @xu_xu, section: @section_225E, value: 4
    @zhang.student_preferences.create! student: @xu_xu, section: @section_340, value: 4
    @christi.student_preferences.create! student: @hongyan_yi, section: @section_362, value: 4
    @sarbaziazad.student_preferences.create! student: @tadesse_zemicheal, section: @section_340, value: 4
    @rosulek.student_preferences.create! student: @baigong_zheng, section: @section_517, value: 4
  end

  def seed_departments
    @computer_science = Department.create! subject_code: "CS"
  end

  def seed_courses
    @course_225 = Course.create! department: @computer_science, course_number: 225
    @course_261 = Course.create! department: @computer_science, course_number: 261
    @course_271 = Course.create! department: @computer_science, course_number: 271
    @course_290 = Course.create! department: @computer_science, course_number: 290
    @course_325 = Course.create! department: @computer_science, course_number: 325
    @course_331 = Course.create! department: @computer_science, course_number: 331
    @course_340 = Course.create! department: @computer_science, course_number: 340
    @course_344 = Course.create! department: @computer_science, course_number: 344
    @course_352 = Course.create! department: @computer_science, course_number: 352
    @course_361 = Course.create! department: @computer_science, course_number: 361
    @course_362 = Course.create! department: @computer_science, course_number: 362
    @course_372 = Course.create! department: @computer_science, course_number: 372
    @course_381 = Course.create! department: @computer_science, course_number: 381
    @course_391 = Course.create! department: @computer_science, course_number: 391
    @course_419 = Course.create! department: @computer_science, course_number: 419
    @course_419_553 = Course.create! department: @computer_science, course_number: 553
    @course_434 = Course.create! department: @computer_science, course_number: 434
    @course_444_544 = Course.create! department: @computer_science, course_number: 444
    @course_463 = Course.create! department: @computer_science, course_number: 463
    @course_472_572 = Course.create! department: @computer_science, course_number: 472
    @course_475_575 = Course.create! department: @computer_science, course_number: 475
    @course_496 = Course.create! department: @computer_science, course_number: 496
    @course_516 = Course.create! department: @computer_science, course_number: 516
    @course_517 = Course.create! department: @computer_science, course_number: 517
    @course_519_599 = Course.create! department: @computer_science, course_number: 519
    @course_533 = Course.create! department: @computer_science, course_number: 533
    @course_421_521 = Course.create! department: @computer_science, course_number: 421
  end

  def seed_sections
    @section_225E = Section.create! current_enrollment: 170, location: 1,   term: 'Sp16', course: @course_225, cc_instructor_tag: "Something else"
    @section_261 = Section.create! current_enrollment: 100, location: 0,   term: 'Sp16', course: @course_261, cc_instructor_tag: "Something else"
    @section_261E = Section.create! current_enrollment: 146, location: 1,   term: 'Sp16', course: @course_261, cc_instructor_tag: "Something else"
    @section_271E = Section.create! current_enrollment: 161, location: 1,   term: 'Sp16', course: @course_271, cc_instructor_tag: "Something else"
    @section_290E = Section.create! current_enrollment: 135, location: 1,   term: 'Sp16', course: @course_290, cc_instructor_tag: "Something else"
    @section_325E = Section.create! current_enrollment: 91, location: 1,   term: 'Sp16', course: @course_325, cc_instructor_tag: "Something else"
    @section_331 = Section.create! current_enrollment: 39, location: 0,   term: 'Sp16', course: @course_331, cc_instructor_tag: "Something else"
    @section_340E = Section.create! current_enrollment: 68, location: 1,   term: 'Sp16', course: @course_340, cc_instructor_tag: "Something else"
    @section_340 = Section.create! current_enrollment: 11, location: 0,   term: 'Sp16', course: @course_340, cc_instructor_tag: "Something else"
    @section_344E = Section.create! current_enrollment: 84, location: 1,   term: 'Sp16', course: @course_344, cc_instructor_tag: "Something else"
    @section_352E = Section.create! current_enrollment: 115, location: 1,   term: 'Sp16', course: @course_352, cc_instructor_tag: "Something else"
    @section_361E = Section.create! current_enrollment: 67, location: 1,   term: 'Sp16', course: @course_361, cc_instructor_tag: "Something else"
    @section_362E = Section.create! current_enrollment: 48, location: 1,   term: 'Sp16', course: @course_362, cc_instructor_tag: "Something else"
    @section_362 = Section.create! current_enrollment: 50, location: 0,   term: 'Sp16', course: @course_362, cc_instructor_tag: "Something else"
    @section_372E = Section.create! current_enrollment: 61, location: 1,   term: 'Sp16', course: @course_372, cc_instructor_tag: "Something else"
    @section_372 = Section.create! current_enrollment: 107, location: 0,   term: 'Sp16', course: @course_372, cc_instructor_tag: "Something else"
    @section_381 = Section.create! current_enrollment: 106, location: 0,   term: 'Sp16', course: @course_381, cc_instructor_tag: "Something else"
    @section_391E = Section.create! current_enrollment: 75, location: 1,   term: 'Sp16', course: @course_391, cc_instructor_tag: "Something else"
    @section_391 = Section.create! current_enrollment: 127, location: 0,   term: 'Sp16', course: @course_391, cc_instructor_tag: "Something else"
    @section_419E = Section.create! current_enrollment: 34, location: 1,   term: 'Sp16', course: @course_419, cc_instructor_tag: "Something else"
    @section_419_553 = Section.create! current_enrollment: 46, location: 0,   term: 'Sp16', course: @course_419_553, cc_instructor_tag: "Something else"
    @section_434 = Section.create! current_enrollment: 30, location: 0,   term: 'Sp16', course: @course_434, cc_instructor_tag: "Something else"
    @section_444_544 = Section.create! current_enrollment: 115, location: 0,   term: 'Sp16', course: @course_444_544, cc_instructor_tag: "Something else"
    @section_463 = Section.create! current_enrollment: 124, location: 0,   term: 'Sp16', course: @course_463, cc_instructor_tag: "Something else"
    @section_472_572 = Section.create! current_enrollment: 149, location: 0,   term: 'Sp16', course: @course_472_572, cc_instructor_tag: "Something else"
    @section_475_575 = Section.create! current_enrollment: 76, location: 0,   term: 'Sp16', course: @course_475_575, cc_instructor_tag: "Something else"
    @section_496E = Section.create! current_enrollment: 53, location: 1,   term: 'Sp16', course: @course_496, cc_instructor_tag: "Something else"
    @section_496 = Section.create! current_enrollment: 43, location: 0,   term: 'Sp16', course: @course_496, cc_instructor_tag: "Something else"
    @section_516 = Section.create! current_enrollment: 13, location: 0,   term: 'Sp16', course: @course_516, cc_instructor_tag: "Something else"
    @section_517 = Section.create! current_enrollment: 48, location: 0,   term: 'Sp16', course: @course_517, cc_instructor_tag: "Something else"
    @section_519_599 = Section.create! current_enrollment: 9, location: 0,   term: 'Sp16', course: @course_519_599, cc_instructor_tag: "Something else"
    @section_533 = Section.create! current_enrollment: 24, location: 0,   term: 'Sp16', course: @course_533, cc_instructor_tag: "Something else"
    @section_421_521 = Section.create! current_enrollment: 53, location: 0,   term: 'Sp16', course: @course_421_521, cc_instructor_tag: "Something else"
  end

  def seed_students
    @keeley_abbott = User.create! first_name: 'Keeley', last_name: 'Abbott', fte: 0.25, email: 'keeley_abbott@oregonstate.edu', cc_instructor_tag: 'N/A'
    @caius_brindescu = User.create! first_name: 'Caius', last_name: 'Brindescu', fte: 0.49, email: 'caius_brindescu@oregonstate.edu', cc_instructor_tag: 'N/A'
    @jonathan_dodge = User.create! first_name: 'Jonathan', last_name: 'Dodge', fte: 0.49, email: 'jonathan_dodge@oregonstate.edu', cc_instructor_tag: 'N/A'
    @laxmi_ganesan = User.create! first_name: 'Laxmi', last_name: 'Ganesan', fte: 0.49, email: 'laxmi_ganesan@oregonstate.edu', cc_instructor_tag: 'N/A'
    @mohammad_reza_ghaeini = User.create! first_name: 'Mohammad Reza', last_name: 'Ghaeini', fte: 0.49, email: 'mohammad_reza_ghaeini@oregonstate.edu', cc_instructor_tag: 'N/A'
    @xinze_guan = User.create! first_name: 'Xinze', last_name: 'Guan', fte: 0.49, email: 'xinze_guan@oregonstate.edu', cc_instructor_tag: 'N/A'
    @jun_he = User.create! first_name: 'Jun', last_name: 'He', fte: 0.49, email: 'jun_he@oregonstate.edu', cc_instructor_tag: 'N/A'
    @zhangxiang_hu = User.create! first_name: 'Zhangxiang', last_name: 'Hu', fte: 0.25, email: 'zhangxiang_hu@oregonstate.edu', cc_instructor_tag: 'N/A'
    @spencer_hubbard = User.create! first_name: 'Spencer', last_name: 'Hubbard', fte: 0.49, email: 'spencer_hubbard@oregonstate.edu', cc_instructor_tag: 'N/A'
    @zahra_iman = User.create! first_name: 'Zahra', last_name: 'Iman', fte: 0.49, email: 'zahra_iman@oregonstate.edu', cc_instructor_tag: 'N/A'
    @jeffrey_juozapaitis = User.create! first_name: 'Jeffrey', last_name: 'Juozapaitis', fte: 0.49, email: 'jeffrey_juozapaitis@oregonstate.edu', cc_instructor_tag: 'N/A'
    @prashant_kumar = User.create! first_name: 'Prashant', last_name: 'Kumar', fte: 0.49, email: 'prashant_kumar@oregonstate.edu', cc_instructor_tag: 'N/A'
    @xingyi_li = User.create! first_name: 'Xingyi', last_name: 'Li', fte: 0.49, email: 'xingyi_li@oregonstate.edu', cc_instructor_tag: 'N/A'
    @xin_liu = User.create! first_name: 'Xin', last_name: 'Liu', fte: 0.25, email: 'xin_liu@oregonstate.edu', cc_instructor_tag: 'N/A'
    @farhana_liza = User.create! first_name: 'Farhana', last_name: 'Liza', fte: 0.49, email: 'farhana_liza@oregonstate.edu', cc_instructor_tag: 'N/A'
    @umme_mannan = User.create! first_name: 'Umme', last_name: 'Mannan', fte: 0.49, email: 'umme_mannan@oregonstate.edu', cc_instructor_tag: 'N/A'
    @shane_mckee = User.create! first_name: 'Shane', last_name: 'Mc Kee', fte: 0.49, email: 'shane_mc_kee@oregonstate.edu', cc_instructor_tag: 'N/A'
    @pranjal_mittal = User.create! first_name: 'Pranjal', last_name: 'Mittal', fte: 0.49, email: 'pranjal_mittal@oregonstate.edu', cc_instructor_tag: 'N/A'
    @sean_moore = User.create! first_name: 'Sean', last_name: 'Moore', fte: 0.49, email: 'sean_moore@oregonstate.edu', cc_instructor_tag: 'N/A'
    @rithika_naik = User.create! first_name: 'Rithika', last_name: 'Naik', fte: 0.49, email: 'rithika_naik@oregonstate.edu', cc_instructor_tag: 'N/A'
    @rasha_obeidat = User.create! first_name: 'Rasha', last_name: 'Obeidat', fte: 0.49, email: 'rasha_obeidat@oregonstate.edu', cc_instructor_tag: 'N/A'
    @nels_oscar = User.create! first_name: 'Nels', last_name: 'Oscar', fte: 0.49, email: 'nels_oscar@oregonstate.edu', cc_instructor_tag: 'N/A'
    @arezoo_rajabi = User.create! first_name: 'Arezoo', last_name: 'Rajabi', fte: 0.49, email: 'arezoo_rajabi@oregonstate.edu', cc_instructor_tag: 'N/A'
    @peter_rindal = User.create! first_name: 'Peter', last_name: 'Rindal', fte: 0.25, email: 'peter_rindal@oregonstate.edu', cc_instructor_tag: 'N/A'
    @hamed_shahbazi = User.create! first_name: 'Hamed', last_name: 'Shahbazi', fte: 0.49, email: 'hamed_shahbazi@oregonstate.edu', cc_instructor_tag: 'N/A'
    @ritesh_sharma = User.create! first_name: 'Ritesh', last_name: 'Sharma', fte: 0.25, email: 'ritesh_sharma@oregonstate.edu', cc_instructor_tag: 'N/A'
    @nitin_subramanian = User.create! first_name: 'Nitin', last_name: 'Subramanian', fte: 0.49, email: 'nitin_subramanian@oregonstate.edu', cc_instructor_tag: 'N/A'
    @xiangyu_wang = User.create! first_name: 'Xiangyu', last_name: 'Wang', fte: 0.25, email: 'xiangyu_wang@oregonstate.edu', cc_instructor_tag: 'N/A'
    @keying_xu = User.create! first_name: 'Keying', last_name: 'Xu', fte: 0.25, email: 'keying_xu@oregonstate.edu', cc_instructor_tag: 'N/A'
    @xu_xu = User.create! first_name: 'Xu', last_name: 'Xu', fte: 0.25, email: 'xu_xu@oregonstate.edu', cc_instructor_tag: 'N/A'
    @fan_yang = User.create! first_name: 'Fan', last_name: 'Yang', fte: 0.25, email: 'fan_yang@oregonstate.edu', cc_instructor_tag: 'N/A'
    @hongyan_yi = User.create! first_name: 'Hongyan', last_name: 'Yi', fte: 0.49, email: 'hongyan_yi@oregonstate.edu', cc_instructor_tag: 'N/A'
    @tadesse_zemicheal = User.create! first_name: 'Tadesse', last_name: 'Zemicheal', fte: 0.49, email: 'tadesse_zemicheal@oregonstate.edu', cc_instructor_tag: 'N/A'
    @baigong_zheng = User.create! first_name: 'Baigong', last_name: 'Zheng', fte: 0.25, email: 'baigong_zheng@oregonstate.edu', cc_instructor_tag: 'N/A'
    @chao_peng = User.create! first_name: 'Chao', last_name: 'Peng', fte: 0.25, email: 'chao_peng@oregonstate.edu', cc_instructor_tag: 'N/A'
    @sherif_abdelwahab = User.create! first_name: 'Sherif', last_name: 'Abdelwahab', fte: 0.49, email: 'sherif_abdelwahab@oregonstate.edu', cc_instructor_tag: 'N/A'
    @sumanth_avadhani = User.create! first_name: 'Sumanth', last_name: 'Avadhani', fte: 0.49, email: 'sumanth_avadhani@oregonstate.edu', cc_instructor_tag: 'N/A'
    @hui_zhang = User.create! first_name: 'Hui', last_name: 'Zhang', fte: 0.49, email: 'hui_zhang@oregonstate.edu', cc_instructor_tag: 'N/A'
    @pingan_zhu = User.create! first_name: 'Pingan', last_name: 'Zhu', fte: 0.49, email: 'pingan_zhu@oregonstate.edu', cc_instructor_tag: 'N/A'
    @wojtec_rajski = User.create! first_name: 'Wojtec', last_name: 'Rajski', fte: 0.49, email: 'wojtec_rajski@oregonstate.edu', cc_instructor_tag: 'N/A'
    @padraic_mcgraw = User.create! first_name: 'Padraic', last_name: 'McGraw', fte: 0.49, email: 'padraic_mcgraw@oregonstate.edu', cc_instructor_tag: 'N/A'
    @william_leslie = User.create! first_name: 'William', last_name: 'Leslie', fte: 0.49, email: 'william_leslie@oregonstate.edu', cc_instructor_tag: 'N/A'
    @shankar_jothi = User.create! first_name: 'Shankar', last_name: 'Jothi', fte: 0.49, email: 'shankar_jothi@oregonstate.edu', cc_instructor_tag: 'N/A'
    @gungor_basa = User.create! first_name: 'Gungor', last_name: 'Basa', fte: 0.25, email: 'gungor_basa@oregonstate.edu', cc_instructor_tag: 'N/A'
    @eric_happe = User.create! first_name: 'Eric', last_name: 'Happe', fte: 0.49, email: 'eric_happe@oregonstate.edu', cc_instructor_tag: 'N/A'
    @dileep_sreekumaran = User.create! first_name: 'Dileep', last_name: 'Sreekumaran', fte: 0.25, email: 'dileep_sreekumaran@oregonstate.edu', cc_instructor_tag: 'N/A'
    @guochen_xu = User.create! first_name: 'Guochen', last_name: 'Xu', fte: 0.49, email: 'guochen_xu@oregonstate.edu', cc_instructor_tag: 'N/A'
    @yao_zhou = User.create! first_name: 'Yao', last_name: 'Zhou', fte: 0.49, email: 'yao_zhou@oregonstate.edu', cc_instructor_tag: 'N/A'
    @khalfi_bassem = User.create! first_name: 'Khalfi', last_name: 'Bassem', fte: 0.49, email: 'khalfi_bassem@oregonstate.edu', cc_instructor_tag: 'N/A'
    @siddharth_mahendra = User.create! first_name: 'Siddharth', last_name: 'Mahendra', fte: 0.25, email: 'siddharth_mahendra@oregonstate.edu', cc_instructor_tag: 'N/A'
  end

  def seed_section_preferences
    @keeley_abbott.section_preferences.create! section: @section_290E, value: 3
    @keeley_abbott.section_preferences.create! section: @section_340E, value: 4
    @keeley_abbott.section_preferences.create! section: @section_361E, value: 3
    @keeley_abbott.section_preferences.create! section: @section_381, value: 4
    @keeley_abbott.section_preferences.create! section: @section_496E, value: 4
    @caius_brindescu.section_preferences.create! section: @section_290E, value: 3
    @caius_brindescu.section_preferences.create! section: @section_344E, value: 3
    @caius_brindescu.section_preferences.create! section: @section_361E, value: 4
    @caius_brindescu.section_preferences.create! section: @section_362E, value: 4
    @caius_brindescu.section_preferences.create! section: @section_496E, value: 4
    @jonathan_dodge.section_preferences.create! section: @section_463, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_340E, value: 3
    @laxmi_ganesan.section_preferences.create! section: @section_352E, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_361E, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_362E, value: 4
    @laxmi_ganesan.section_preferences.create! section: @section_496E, value: 3
    @mohammad_reza_ghaeini.section_preferences.create! section: @section_261E, value: 3
    @mohammad_reza_ghaeini.section_preferences.create! section: @section_290E, value: 3
    @mohammad_reza_ghaeini.section_preferences.create! section: @section_325E, value: 4
    @mohammad_reza_ghaeini.section_preferences.create! section: @section_331, value: 4
    @mohammad_reza_ghaeini.section_preferences.create! section: @section_340E, value: 4
    @xinze_guan.section_preferences.create! section: @section_463, value: 4
    @jun_he.section_preferences.create! section: @section_225E, value: 4
    @jun_he.section_preferences.create! section: @section_290E, value: 4
    @jun_he.section_preferences.create! section: @section_331, value: 3
    @jun_he.section_preferences.create! section: @section_391E, value: 4
    @jun_he.section_preferences.create! section: @section_434, value: 3
    @zhangxiang_hu.section_preferences.create! section: @section_261E, value: 4
    @zhangxiang_hu.section_preferences.create! section: @section_290E, value: 3
    @zhangxiang_hu.section_preferences.create! section: @section_325E, value: 4
    @zhangxiang_hu.section_preferences.create! section: @section_344E, value: 3
    @zhangxiang_hu.section_preferences.create! section: @section_372E, value: 4
    @spencer_hubbard.section_preferences.create! section: @section_225E, value: 3
    @spencer_hubbard.section_preferences.create! section: @section_261E, value: 4
    @spencer_hubbard.section_preferences.create! section: @section_290E, value: 4
    @spencer_hubbard.section_preferences.create! section: @section_325E, value: 4
    @spencer_hubbard.section_preferences.create! section: @section_381, value: 3
    @zahra_iman.section_preferences.create! section: @section_225E, value: 4
    @zahra_iman.section_preferences.create! section: @section_261E, value: 3
    @zahra_iman.section_preferences.create! section: @section_271E, value: 4
    @zahra_iman.section_preferences.create! section: @section_352E, value: 4
    @zahra_iman.section_preferences.create! section: @section_391E, value: 3
    @jeffrey_juozapaitis.section_preferences.create! section: @section_225E, value: 3
    @jeffrey_juozapaitis.section_preferences.create! section: @section_261E, value: 3
    @jeffrey_juozapaitis.section_preferences.create! section: @section_325E, value: 4
    @jeffrey_juozapaitis.section_preferences.create! section: @section_331, value: 4
    @jeffrey_juozapaitis.section_preferences.create! section: @section_434, value: 4
    @prashant_kumar.section_preferences.create! section: @section_225E, value: 3
    @prashant_kumar.section_preferences.create! section: @section_261E, value: 4
    @prashant_kumar.section_preferences.create! section: @section_325E, value: 4
    @prashant_kumar.section_preferences.create! section: @section_340E, value: 4
    @prashant_kumar.section_preferences.create! section: @section_381, value: 3
    @xingyi_li.section_preferences.create! section: @section_225E, value: 4
    @xingyi_li.section_preferences.create! section: @section_331, value: 3
    @xingyi_li.section_preferences.create! section: @section_361E, value: 3
    @xingyi_li.section_preferences.create! section: @section_391E, value: 4
    @xingyi_li.section_preferences.create! section: @section_434, value: 4
    @xin_liu.section_preferences.create! section: @section_261E, value: 4
    @xin_liu.section_preferences.create! section: @section_381, value: 4
    @xin_liu.section_preferences.create! section: @section_496E, value: 4
    @farhana_liza.section_preferences.create! section: @section_261E, value: 4
    @farhana_liza.section_preferences.create! section: @section_344E, value: 4
    @farhana_liza.section_preferences.create! section: @section_361E, value: 4
    @farhana_liza.section_preferences.create! section: @section_372E, value: 3
    @farhana_liza.section_preferences.create! section: @section_381, value: 3
    @umme_mannan.section_preferences.create! section: @section_340E, value: 3
    @umme_mannan.section_preferences.create! section: @section_352E, value: 3
    @umme_mannan.section_preferences.create! section: @section_361E, value: 4
    @umme_mannan.section_preferences.create! section: @section_362E, value: 4
    @umme_mannan.section_preferences.create! section: @section_391E, value: 4
    @shane_mckee.section_preferences.create! section: @section_261E, value: 3
    @shane_mckee.section_preferences.create! section: @section_290E, value: 4
    @shane_mckee.section_preferences.create! section: @section_361E, value: 4
    @shane_mckee.section_preferences.create! section: @section_362E, value: 4
    @shane_mckee.section_preferences.create! section: @section_391E, value: 3
    @pranjal_mittal.section_preferences.create! section: @section_261E, value: 3
    @pranjal_mittal.section_preferences.create! section: @section_290E, value: 4
    @pranjal_mittal.section_preferences.create! section: @section_325E, value: 3
    @pranjal_mittal.section_preferences.create! section: @section_340E, value: 4
    @pranjal_mittal.section_preferences.create! section: @section_496E, value: 4
    @sean_moore.section_preferences.create! section: @section_225E, value: 4
    @sean_moore.section_preferences.create! section: @section_261E, value: 4
    @sean_moore.section_preferences.create! section: @section_290E, value: 3
    @sean_moore.section_preferences.create! section: @section_381, value: 3
    @rithika_naik.section_preferences.create! section: @section_225E, value: 3
    @rithika_naik.section_preferences.create! section: @section_261E, value: 3
    @rithika_naik.section_preferences.create! section: @section_290E, value: 4
    @rithika_naik.section_preferences.create! section: @section_361E, value: 4
    @rithika_naik.section_preferences.create! section: @section_391E, value: 4
    @rasha_obeidat.section_preferences.create! section: @section_261E, value: 4
    @rasha_obeidat.section_preferences.create! section: @section_325E, value: 4
    @rasha_obeidat.section_preferences.create! section: @section_331, value: 3
    @rasha_obeidat.section_preferences.create! section: @section_340E, value: 4
    @rasha_obeidat.section_preferences.create! section: @section_434, value: 3
    @nels_oscar.section_preferences.create! section: @section_463, value: 4
    @arezoo_rajabi.section_preferences.create! section: @section_261E, value: 4
    @arezoo_rajabi.section_preferences.create! section: @section_325E, value: 4
    @arezoo_rajabi.section_preferences.create! section: @section_331, value: 3
    @arezoo_rajabi.section_preferences.create! section: @section_340E, value: 4
    @arezoo_rajabi.section_preferences.create! section: @section_344E, value: 3
    @peter_rindal.section_preferences.create! section: @section_261E, value: 4
    @peter_rindal.section_preferences.create! section: @section_325E, value: 4
    @peter_rindal.section_preferences.create! section: @section_340E, value: 3
    @peter_rindal.section_preferences.create! section: @section_344E, value: 4
    @hamed_shahbazi.section_preferences.create! section: @section_261E, value: 4
    @hamed_shahbazi.section_preferences.create! section: @section_325E, value: 3
    @hamed_shahbazi.section_preferences.create! section: @section_340E, value: 4
    @hamed_shahbazi.section_preferences.create! section: @section_361E, value: 3
    @hamed_shahbazi.section_preferences.create! section: @section_381, value: 3
    @hamed_shahbazi.section_preferences.create! section: @section_434, value: 4
    @ritesh_sharma.section_preferences.create! section: @section_261E, value: 4
    @ritesh_sharma.section_preferences.create! section: @section_290E, value: 3
    @ritesh_sharma.section_preferences.create! section: @section_325E, value: 4
    @ritesh_sharma.section_preferences.create! section: @section_340E, value: 4
    @ritesh_sharma.section_preferences.create! section: @section_344E, value: 3
    @nitin_subramanian.section_preferences.create! section: @section_290E, value: 3
    @nitin_subramanian.section_preferences.create! section: @section_340E, value: 4
    @nitin_subramanian.section_preferences.create! section: @section_361E, value: 4
    @nitin_subramanian.section_preferences.create! section: @section_391E, value: 4
    @xiangyu_wang.section_preferences.create! section: @section_261E, value: 3
    @xiangyu_wang.section_preferences.create! section: @section_271E, value: 4
    @xiangyu_wang.section_preferences.create! section: @section_325E, value: 4
    @xiangyu_wang.section_preferences.create! section: @section_361E, value: 3
    @xiangyu_wang.section_preferences.create! section: @section_381, value: 4
    @keying_xu.section_preferences.create! section: @section_225E, value: 4
    @keying_xu.section_preferences.create! section: @section_261E, value: 3
    @keying_xu.section_preferences.create! section: @section_362E, value: 3
    @keying_xu.section_preferences.create! section: @section_381, value: 4
    @keying_xu.section_preferences.create! section: @section_391E, value: 4
    @xu_xu.section_preferences.create! section: @section_225E, value: 4
    @xu_xu.section_preferences.create! section: @section_325E, value: 4
    @xu_xu.section_preferences.create! section: @section_331, value: 4
    @xu_xu.section_preferences.create! section: @section_381, value: 3
    @xu_xu.section_preferences.create! section: @section_434, value: 3
    @fan_yang.section_preferences.create! section: @section_261E, value: 4
    @fan_yang.section_preferences.create! section: @section_325E, value: 4
    @fan_yang.section_preferences.create! section: @section_331, value: 4
    @fan_yang.section_preferences.create! section: @section_340E, value: 3
    @fan_yang.section_preferences.create! section: @section_361E, value: 3
    @hongyan_yi.section_preferences.create! section: @section_261E, value: 4
    @hongyan_yi.section_preferences.create! section: @section_271E, value: 3
    @hongyan_yi.section_preferences.create! section: @section_325E, value: 3
    @hongyan_yi.section_preferences.create! section: @section_340E, value: 4
    @hongyan_yi.section_preferences.create! section: @section_362E, value: 4
    @tadesse_zemicheal.section_preferences.create! section: @section_325E, value: 4
    @tadesse_zemicheal.section_preferences.create! section: @section_340E, value: 4
    @tadesse_zemicheal.section_preferences.create! section: @section_344E, value: 4
    @tadesse_zemicheal.section_preferences.create! section: @section_362E, value: 3
    @tadesse_zemicheal.section_preferences.create! section: @section_434, value: 3
    @baigong_zheng.section_preferences.create! section: @section_261E, value: 4
    @baigong_zheng.section_preferences.create! section: @section_290E, value: 3
    @baigong_zheng.section_preferences.create! section: @section_325E, value: 4
    @baigong_zheng.section_preferences.create! section: @section_340E, value: 3
    @baigong_zheng.section_preferences.create! section: @section_517, value: 4
    @chao_peng.section_preferences.create! section: @section_261E, value: 4
    @chao_peng.section_preferences.create! section: @section_325E, value: 4
    @chao_peng.section_preferences.create! section: @section_372E, value: 3
    @chao_peng.section_preferences.create! section: @section_381, value: 4
    @sherif_abdelwahab.section_preferences.create! section: @section_372E, value: 4
    @sumanth_avadhani.section_preferences.create! section: @section_271E, value: 4
    @hui_zhang.section_preferences.create! section: @section_271E, value: 4
    @pingan_zhu.section_preferences.create! section: @section_271E, value: 4
    @pingan_zhu.section_preferences.create! section: @section_419E, value: 4
    @wojtec_rajski.section_preferences.create! section: @section_391E, value: 4
    @shankar_jothi.section_preferences.create! section: @section_391E, value: 4
    @eric_happe.section_preferences.create! section: @section_344E, value: 4
    @dileep_sreekumaran.section_preferences.create! section: @section_225E, value: 4
    @guochen_xu.section_preferences.create! section: @section_261E, value: 4
    @yao_zhou.section_preferences.create! section: @section_261E, value: 4
    @khalfi_bassem.section_preferences.create! section: @section_372E, value: 4
    @siddharth_mahendra.section_preferences.create! section: @section_271E, value: 4
  end

end

ilp = SpringIlp.new
ilp.run
