**FREE

ctl-opt dftactgrp(*NO) actgrp(*CALLER);
ctl-opt option(*SRCSTMT: *NODEBUGIO);
ctl-opt bnddir('IBMIUNIT/IBMIUNIT': 'RPG5LIB');

/copy IBMiUnit/qrpglesrc,ibmiunit_h
/COPY RPG5LIB,in_h


*inLR = *ON;

IBMiUnit_setupSuite('R5UTILS IN module - Test r5_in_*');

IBMiUnit_addTestCase(%paddr(test_in_char): 'test_in_char');
IBMiUnit_addTestCase(%paddr(test_in_varchar): 'test_in_varchar');
IBMiUnit_addTestCase(%paddr(test_in_dec): 'test_in_dec');
IBMiUnit_addTestCase(%paddr(test_in_int): 'test_in_int');
IBMiUnit_addTestCase(%paddr(test_in_date): 'test_in_date');
IBMiUnit_addTestCase(%paddr(test_in_time): 'test_in_time');
IBMiUnit_addTestCase(%paddr(test_in_ts): 'test_in_ts');

IBMiUnit_teardownSuite();
return;

dcl-proc test_in_char;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-ds alphabet;
      *N char(10) inz(' ABCDEFGHI');
      char char(1) dim(10) pos(1);
   end-ds;

   dcl-s i like(r5_small_t);

   for i = 1 to %elem(char);
      assertOn(r5_in_char(char(i): ' ': 'A': 'B': 'C': 'D': 'E': 'F': 'G': 'H': 'I'));
   endfor;

   assertOff(r5_in_char('Z': ' ': 'A': 'B': 'C': 'D': 'E': 'F': 'G': 'H': 'I'));
   assertOff(r5_in_char('0': ' ': 'A': 'B': 'C': 'D': 'E': 'F': 'G': 'H': 'I'));

   assertOn(r5_in_char('5': ' ': '1': '3': '5': '7': '9'));
   assertOff(r5_in_char('6': ' ': '1': '3': '5': '7': '9'));

   assertOn(r5_in_char('b': 'a': 'b'));
   assertOff(r5_in_char('c': 'a': 'b'));
   return;
end-proc;


dcl-proc test_in_varchar;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-ds animals;
      *N char(10) inz('elephant');
      *N char(10) inz('giraffe');
      *N char(10) inz('zebra');
      *N char(10) inz('lion');
      *N char(10) inz('tiger');
      *N char(10) inz('rhino');
      *N char(10) inz('gorilla');
      animal char(10) dim(7) pos(1);
   end-ds;

   dcl-s i like(r5_small_t);

   for i = 1 to %elem(animal);
      assertOn(r5_in_char( animal(i)
                         : 'giraffe': 'tiger': 'gorilla': 'dolphin': 'rhino'
                         : 'human': 'elephant': 'dog': 'zebra': 'lion'));
   endfor;

   assertOff(r5_in_char( 'monkey'
                       : 'girafe': 'tiger': 'gorilla': 'dolphin': 'rhino'
                       : 'human': 'elephant': 'dog': 'zebra': 'lion'));
   assertOff(r5_in_char( 'panther'
                       : 'girafe': 'tiger': 'gorilla': 'dolphin': 'rhino'
                       : 'human': 'elephant': 'dog': 'zebra': 'lion'));

   assertOn(r5_in_char( 'cat': 'tiger': 'dog': 'lion': 'cat'));
   assertOff(r5_in_char( 'bird': 'tiger': 'dog': 'lion': 'cat'));

   assertOn(r5_in_char( 'cat': 'cat'));
   assertOff(r5_in_char( 'dog': 'cat'));
   return;
end-proc;


dcl-proc test_in_dec;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-s i like(r5_small_t);
   dcl-s dec packed(7: 3);

   for i = 0 to 9;
      assertOn(r5_in_dec(i: 0: 1: 2: 3: 4: 5: 6: 7: 8: 9 ));
   endfor;

   assertOff(r5_in_dec(-1: 0: 1: 2: 3: 4: 5: 6: 7: 8: 9 ));
   assertOff(r5_in_dec(10: 0: 1: 2: 3: 4: 5: 6: 7: 8: 9 ));

   dec = 0;
   for i = 1 to 9;
      dec += 0,10;
      assertOn(r5_in_dec(dec: 0: 0.1: 0.2: 0.3: 0.4: 0.5: 0.6: 0.7: 0.8: 0.9 ));
   endfor;

   assertOff(r5_in_dec(0.15: 0: 0.1: 0.2: 0.3: 0.4: 0.5: 0.6: 0.7: 0.8: 0.9 ));
   assertOff(r5_in_dec(-0.2: 0: 0.1: 0.2: 0.3: 0.4: 0.5: 0.6: 0.7: 0.8: 0.9 ));
   assertOff(r5_in_dec(10.25: 0: 0.1: 0.2: 0.3: 0.4: 0.5: 0.6: 0.7: 0.8: 0.9 ));

   assertOn(r5_in_dec(1532.9381: 0: 125384.352816: 325.05: 1532.9381));
   assertOff(r5_in_dec(856217.56428: 0: 125384.352816: 325.05: 1532.9381));

   assertOn(r5_in_dec(33647293.5848: 33647293.5848));
   assertOff(r5_in_dec(33647293.5848: 35648273.5318));
   return;
end-proc;


dcl-proc test_in_int;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-s i like(r5_small_t);

   for i = 0 to 9;
      assertOn(r5_in_int(i: 0: 1: 2: 3: 4: 5: 6: 7: 8: 9 ));
   endfor;

   assertOff(r5_in_int(-1: 0: 1: 2: 3: 4: 5: 6: 7: 8: 9 ));
   assertOff(r5_in_int(10: 0: 1: 2: 3: 4: 5: 6: 7: 8: 9 ));

   assertOn(r5_in_int(-5: -9: -7: -5));
   assertOff(r5_in_int(125: 124: 123: 122));

   assertOn(r5_in_int(8: 8));
   assertOff(r5_in_int(125: 8));
   return;
end-proc;


dcl-proc test_in_date;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-s i like(r5_small_t);
   dcl-s date like(r5_date_t);

   date = D'2023-03-28';

   for i = 1 to 10;
      assertOn(r5_in_date(date: D'2023-03-28': D'2023-04-02': D'2023-04-07': D'2023-04-12'
                              : D'2023-04-17': D'2023-04-22': D'2023-04-27': D'2023-05-02'
                              : D'2023-05-07': D'2023-05-12'
              ));
      date += %days(5);
   endfor;

   date = D'2023-03-27';
   assertOff(r5_in_date(date: D'2023-03-28': D'2023-04-02': D'2023-04-07': D'2023-04-12'
                            : D'2023-04-17': D'2023-04-22': D'2023-04-27': D'2023-05-02'
                            : D'2023-05-07': D'2023-05-12'
            ));
   date = D'2023-05-13';
   assertOff(r5_in_date(date: D'2023-03-28': D'2023-04-02': D'2023-04-07': D'2023-04-12'
                            : D'2023-04-17': D'2023-04-22': D'2023-04-27': D'2023-05-02'
                            : D'2023-05-07': D'2023-05-12'
            ));
   date = D'2023-04-14';
   assertOff(r5_in_date(date: D'2023-03-28': D'2023-04-02': D'2023-04-07': D'2023-04-12'
                            : D'2023-04-17': D'2023-04-22': D'2023-04-27': D'2023-05-02'
                            : D'2023-05-07': D'2023-05-12'
            ));

   assertOn(r5_in_date(D'2023-03-28': D'2023-02-28': D'2024-03-28': D'2023-03-28'));
   assertOff(r5_in_date(D'2023-03-29': D'2023-02-28': D'2024-03-28': D'2023-03-28'));

   assertOn(r5_in_date(D'2023-03-31': D'2023-03-31'));
   assertOff(r5_in_date(D'2023-03-30': D'2023-03-31'));
   return;
end-proc;


dcl-proc test_in_time;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-s i like(r5_small_t);
   dcl-s time like(r5_time_t);

   time = T'18.19.53';

   for i = 1 to 10;
      assertOn(r5_in_time(time: T'18.19.53': T'18.20.10': T'18.20.27': T'18.20.44'
                              : T'18.21.01': T'18.21.18': T'18.21.35': T'18.21.52'
                              : T'18.22.09': T'18.22.26'
              ));
      time += %seconds(17);
   endfor;

   time = T'18.19.52';
   assertOff(r5_in_time(time: T'18.19.53': T'18.20.10': T'18.20.27': T'18.20.44'
                            : T'18.21.01': T'18.21.18': T'18.21.35': T'18.21.52'
                            : T'18.22.09': T'18.22.26'
           ));
   time = T'18.22.27';
   assertOff(r5_in_time(time: T'18.19.53': T'18.20.10': T'18.20.27': T'18.20.44'
                            : T'18.21.01': T'18.21.18': T'18.21.35': T'18.21.52'
                            : T'18.22.09': T'18.22.26'
           ));
   time = T'18.21.30';
   assertOff(r5_in_time(time: T'18.19.53': T'18.20.10': T'18.20.27': T'18.20.44'
                            : T'18.21.01': T'18.21.18': T'18.21.35': T'18.21.52'
                            : T'18.22.09': T'18.22.26'
           ));

   assertOn(r5_in_time(T'17.30.00': T'17.25.10': T'17.27.40': T'17.30.00'));
   assertOff(r5_in_time(T'17.35.00': T'17.25.10': T'17.27.40': T'17.30.00'));

   assertOn(r5_in_time(T'19.07.32': T'19.07.32'));
   assertOff(r5_in_time(T'07.07.32': T'19.07.32'));
   return;
end-proc;


dcl-proc test_in_ts;
   dcl-pi *N extproc(*DCLCASE) end-pi;

   dcl-s i like(r5_small_t);
   dcl-s ts like(r5_time_stamp_t);

   ts = Z'2023-03-28-15.49.18';

   for i = 1 to 10;
      assertOn(r5_in_ts(ts: Z'2023-03-28-15.49.18.000000': Z'2023-03-28-15.49.18.000300'
                          : Z'2023-03-28-15.49.18.000600': Z'2023-03-28-15.49.18.000900'
                          : Z'2023-03-28-15.49.18.001200': Z'2023-03-28-15.49.18.001500'
                          : Z'2023-03-28-15.49.18.001800': Z'2023-03-28-15.49.18.002100'
                          : Z'2023-03-28-15.49.18.002400': Z'2023-03-28-15.49.18.002700'
              ));
      ts += %mseconds(300);
   endfor;

   ts = Z'2023-03-28-15.49.17.999999';
   assertOff(r5_in_ts(ts: Z'2023-03-28-15.49.18.000000': Z'2023-03-28-15.49.18.000300'
                        : Z'2023-03-28-15.49.18.000600': Z'2023-03-28-15.49.18.000900'
                        : Z'2023-03-28-15.49.18.001200': Z'2023-03-28-15.49.18.001500'
                        : Z'2023-03-28-15.49.18.001800': Z'2023-03-28-15.49.18.002100'
                        : Z'2023-03-28-15.49.18.002400': Z'2023-03-28-15.49.18.002700'
            ));
   ts = Z'2023-03-28-15.49.18.002701';
   assertOff(r5_in_ts(ts: Z'2023-03-28-15.49.18.000000': Z'2023-03-28-15.49.18.000300'
                        : Z'2023-03-28-15.49.18.000600': Z'2023-03-28-15.49.18.000900'
                        : Z'2023-03-28-15.49.18.001200': Z'2023-03-28-15.49.18.001500'
                        : Z'2023-03-28-15.49.18.001800': Z'2023-03-28-15.49.18.002100'
                        : Z'2023-03-28-15.49.18.002400': Z'2023-03-28-15.49.18.002700'
            ));
   ts = Z'2023-03-28-15.49.18.001205';
   assertOff(r5_in_ts(ts: Z'2023-03-28-15.49.18.000000': Z'2023-03-28-15.49.18.000300'
                        : Z'2023-03-28-15.49.18.000600': Z'2023-03-28-15.49.18.000900'
                        : Z'2023-03-28-15.49.18.001200': Z'2023-03-28-15.49.18.001500'
                        : Z'2023-03-28-15.49.18.001800': Z'2023-03-28-15.49.18.002100'
                        : Z'2023-03-28-15.49.18.002400': Z'2023-03-28-15.49.18.002700'
            ));

   assertOn(r5_in_ts( Z'2023-03-28-16.23.15.000123'
                    : Z'2023-03-28-16.23.15.000121': Z'2023-03-28-16.23.15.000122'
                    : Z'2023-03-28-16.23.15.000123'
           ));
   assertOff(r5_in_ts( Z'2023-03-28-16.23.15.000124'
                     : Z'2023-03-28-16.23.15.000121': Z'2023-03-28-16.23.15.000122'
                     : Z'2023-03-28-16.23.15.000123'
            ));

   assertOn(r5_in_ts(Z'2023-03-28-16.23.15.000200': Z'2023-03-28-16.23.15.000200'));
   assertOff(r5_in_ts(Z'2023-03-28-16.23.16.000200': Z'2023-03-28-16.23.15.000200'));
   return;
end-proc;

