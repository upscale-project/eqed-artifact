integer f;
initial begin
	f = $fopen("/rsgs/scratch0/nasavare/log.txt","w");
end

always #100
begin
   $fwrite(f,"%t: 1 : test_top.a: %b\n", $time,test_top.a);
   $fwrite(f,"%t: 1 : test_top.b: %b\n", $time,test_top.b);
   $fwrite(f,"%t: 1 : test_top.c: %b\n", $time,test_top.c);
   $fwrite(f,"%t: 1 : test_top.result: %b\n", $time,test_top.result);
      $fwrite(f,"%t: 2 : test_top.first_add.a_add: %b\n", $time,test_top.first_add.a_add);
      $fwrite(f,"%t: 2 : test_top.first_add.b_add: %b\n", $time,test_top.first_add.b_add);
      $fwrite(f,"%t: 2 : test_top.first_add.out_add: %b\n", $time,test_top.first_add.out_add);
      $fwrite(f,"%t: 2 : test_top.first_sub.a_sub: %b\n", $time,test_top.first_sub.a_sub);
      $fwrite(f,"%t: 2 : test_top.first_sub.b_sub: %b\n", $time,test_top.first_sub.b_sub);
      $fwrite(f,"%t: 2 : test_top.first_sub.out_sub: %b\n", $time,test_top.first_sub.out_sub);
end
integer f;
initial begin
	f = $fopen("/rsgs/scratch0/nasavare/test_modules/log.txt","w");
end

integer f;
initial begin
	f = $fopen("/rsgs/scratch0/nasavare/test_modules/log.txt","w");
end

always #100
begin
   $fwrite(f,"%t: 1 : test_top.a: %b\n", $time,test_top.a);
   $fwrite(f,"%t: 1 : test_top.b: %b\n", $time,test_top.b);
   $fwrite(f,"%t: 1 : test_top.c: %b\n", $time,test_top.c);
   $fwrite(f,"%t: 1 : test_top.result: %b\n", $time,test_top.result);
      $fwrite(f,"%t: 2 : test_top.first_add.a_add: %b\n", $time,test_top.first_add.a_add);
      $fwrite(f,"%t: 2 : test_top.first_add.b_add: %b\n", $time,test_top.first_add.b_add);
      $fwrite(f,"%t: 2 : test_top.first_add.out_add: %b\n", $time,test_top.first_add.out_add);
      $fwrite(f,"%t: 2 : test_top.first_sub.a_sub: %b\n", $time,test_top.first_sub.a_sub);
      $fwrite(f,"%t: 2 : test_top.first_sub.b_sub: %b\n", $time,test_top.first_sub.b_sub);
      $fwrite(f,"%t: 2 : test_top.first_sub.out_sub: %b\n", $time,test_top.first_sub.out_sub);
end
