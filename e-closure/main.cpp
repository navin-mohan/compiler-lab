#include <fstream>
#include <map>
#include <set>
#include <queue>
#include <iostream>
#include <utility>


using namespace std;



typedef map<pair<char,char>,set<char>> TransitionTable;


void loadStates(const string filename, TransitionTable& tt, set<char>& states){
	ifstream state_file(filename,fstream::in);
	char start,input,end;

	while(state_file >> start >> input >> end){
		tt[make_pair(start,input)].insert(end);
		states.insert(start);
	}

	state_file.close();
}


set<char> eclose(char state, TransitionTable tt){
	set<char> closure;
	queue<char> q;

	q.push(state);

	while(!q.empty()){	
		char current_state = q.front();
		q.pop();
		closure.insert(current_state);

		for(auto _state: tt[make_pair(current_state,'e')]){
			if(closure.count(_state) == 0){
				q.push(_state);
			}
		}
	}

	return closure;
}

int main(){
	const string filename("states.txt");
	set<char> states;
	TransitionTable tt;

	loadStates(filename,tt,states);
	for(auto state: states){
		cout << state << ": [";
		for(auto closure_state: eclose(state,tt)){
			cout << closure_state << ", ";
		}
		cout << "]" << endl;
	}



	return 0;
}
