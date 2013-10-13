# for Intel Mac
define regs
call (void)printf("eax=%08x ebx=%08x ecx=%08x edx=%08x\nesi=%08x edi=%08x ebp=%08x esp=%08x eip=%08x\n",$eax,$ebx,$ecx,$edx,$esi,$edi,$ebp,$esp,$eip)
end
define si
stepi
regs
x/1i $eip
end
define ni
nexti
regs
x/1i $eip
end

