// Don Report v1 — read-only report entrypoint, completely separate from CONSUME.ash.
// Does NOT import diet optimization code and cannot execute consumption plans.
// call CONSUME/DON_REPORT.ash organ_state [--quiet|--print|--diff]
// call CONSUME/DON_REPORT.ash skills_current [--quiet|--print|--diff]

void main(string args)
{
  string [int] parts = split_string(args, " ");
  string action = parts[0];
  boolean quiet = index_of(args, "--quiet") >= 0 && index_of(args, "--print") < 0;
  boolean diff = index_of(args, "--diff") >= 0;
  if(action == "" || action == "help")
  {
    print("Don CONSUME report (read-only): organ_state | skills_current | status");
    print("Options: --quiet, --print, --diff. Recording/relay hooks NOT installed.");
    return;
  }
  if(action != "organ_state" && action != "skills_current" && action != "status")
  {
    print("Don CONSUME report: unknown command; no consumption attempted.", "red");
    return;
  }
  if(action == "status")
  {
    print("Don CONSUME report is local-only; automatic relay capture disabled.");
    return;
  }
  if(diff)
    print("KNOWN_UNKNOWN: no verified prior scoped receipt for comparison.", "orange");
  string prefix = "donstate:v1:" + my_id() + ":" + today_to_string() +
    ":" + my_ascensions();
  if(action == "organ_state")
  {
    if(!quiet)
    {
      print(prefix + ":organs:organ/1:liver_used = " + my_inebriety());
      print(prefix + ":organs:organ/1:liver_limit = " + inebriety_limit());
      print(prefix + ":organs:organ/1:stomach_used = " + my_fullness());
      print(prefix + ":organs:organ/1:stomach_limit = " + fullness_limit());
      print(prefix + ":organs:organ/1:spleen_used = " + my_spleen_use());
      print(prefix + ":organs:organ/1:spleen_limit = " + spleen_limit());
    }
    print("Don CONSUME: cached organ status observed; NO diet or consumption executed.");
    return;
  }
  boolean [skill] permanent = get_permed_skills();
  int count = 0;
  foreach sk in $skills[]
  {
    if(!have_skill(sk))
      continue;
    count += 1;
    string status = "not_permanent";
    if(permanent contains sk)
      status = permanent[sk] ? "hardcore_perm" : "softcore_perm";
    if(!quiet)
      print(prefix + ":skills:skill/" + to_int(sk) + ":current = true [" + status + "]");
  }
  print("Don CONSUME: " + count + " current skills observed; NO consumption executed.");
}
