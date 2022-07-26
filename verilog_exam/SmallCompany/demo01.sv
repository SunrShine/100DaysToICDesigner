
parameter    MAX_NUM = 100;
parameter    MIN_NUM = 200;
int num_rand;

initial begin
    int q [$];
    for (int i=0; i<1000; i++) begin
        num_rand = MIN_NUM + {$random()} % (MAX_NUM-MIN_NUM+1);
        q.push_back(num_rand);
    end
end