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

TransitionTable removeEplison(TransitionTable tt,map<char,set<char>>& eclose){
	
	set<char> epsilon_states;
	
	for(auto transition: tt){
		if(transition.first.second == 'e'){
			epsilon_states.insert(transition.first.first);
		}
	}

	for(auto transition: tt){
		char input = transition.first.second;
		char start = transition.first.first;
		if(input != 'e' && epsilon_states.count(start) == 1){
			for(auto state: eclose[start]){
				for(auto s: tt[make_pair(state,input)]){
					tt[make_pair(start,input)].insert(s);
				}
			}
		}
	}

	for(auto it = tt.begin(); it != tt.end();++it){
		if(it->first.second == 'e'){
			tt.erase(it);
		}
	}

	return tt;
}

int main(){
	const string filename("states.txt");
	set<char> states;
	TransitionTable tt,new_tt;
	map<char,set<char>> eclose_table;

	loadStates(filename,tt,states);
	for(auto state: states){
		cout << state << ": [";
		eclose_table[state] = eclose(state,tt);
		for(auto closure_state: eclose_table[state]){
			cout << closure_state << ", ";
		}
		cout << "]" << endl;
	}

	new_tt = removeEplison(tt,eclose_table);

	for(auto transition: new_tt){
		cout << transition.first.first << " " << transition.first.second << " ";
		for(auto el: transition.second){
			cout << el << ",";
		}
		cout << endl;
	}



	return 0;
}
